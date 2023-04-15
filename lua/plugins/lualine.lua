local M = {
  'JManch/lualine.nvim',
  lazy = false,
  enabled = true,
}

local tabs = function()
  local tab_count = vim.fn.tabpagenr('$')
  if tab_count ~= 1 then
    return vim.fn.tabpagenr() .. '/' .. tab_count
  end
  return ''
end

local macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

-- Stores length of components on left and right side
-- Used for centering the filename
local component_lengths = { left = {}, right = {} }

local debug_centering = false

local center_cushion = function(side)
  local left = 0
  local right = 0
  local debug = ''
  for k, v in pairs(component_lengths.left) do
    if debug_centering then
      debug = debug .. ' ' .. k .. ': ' .. v
    end
    left = left + v
  end
  for k, v in pairs(component_lengths.right) do
    if debug_centering then
      debug = debug .. ' ' .. k .. ': ' .. v
    end
    right = right + v
  end
  if debug_centering then
    print(debug)
  end
  local diff = left - right
  if side == 'left' and diff < 0 then
    return string.rep(' ', math.abs(diff))
  elseif side == 'right' and diff > 0 then
    return string.rep(' ', diff)
  else
    return ''
  end
end

-- All of this stuff is just for centering the filename
local update_length = {
  mode = function(str, _)
    component_lengths.left.mode = #str + 2
    return str
  end,
  macro_recording = function(str, _)
    component_lengths.left.macro_recording = #str + 1
    return str
  end,
  hostname = function(str, _)
    component_lengths.left.hostname = #str + 1
    return str
  end,
  branch = function(str, _)
    if str == '' then
      component_lengths.left.branch = 0
    else
      component_lengths.left.branch = #str + 3
    end
    return str
  end,
  diff = function(str, info)
    if info.git_diff == nil then
      component_lengths.left.diff = 0
      return str
    end
    local count = 0
    local length = 0
    if info.git_diff.added ~= nil and info.git_diff.added ~= 0 then
      length = length + #tostring(info.git_diff.added)
      count = count + 1
    end
    if info.git_diff.modified ~= nil and info.git_diff.modified ~= 0 then
      length = length + #tostring(info.git_diff.modified)
      count = count + 1
    end
    if info.git_diff.removed ~= nil and info.git_diff.removed ~= 0 then
      length = length + #tostring(info.git_diff.removed)
      count = count + 1
    end
    if count == 0 then
      component_lengths.left.diff = 0
    else
      component_lengths.left.diff = length + 2 * count
    end
    return str
  end,
  diagnostics = function(str, info)
    if info.diagnostics_count == nil then
      component_lengths.right.diagnostics = 0
      return str
    end
    local length = 0
    local count = 0
    if info.diagnostics_count.error ~= 0 then
      length = length + #tostring(info.diagnostics_count.error)
      count = count + 1
    end
    if info.diagnostics_count.hint ~= 0 then
      length = length + #tostring(info.diagnostics_count.hint)
      count = count + 1
    end
    if info.diagnostics_count.info ~= 0 then
      length = length + #tostring(info.diagnostics_count.info)
      count = count + 1
    end
    if info.diagnostics_count.warn ~= 0 then
      length = length + #tostring(info.diagnostics_count.warn)
      count = count + 1
    end
    if count == 0 then
      component_lengths.right.diagnostics = 0
    else
      component_lengths.right.diagnostics = length + 3 * count
    end
    return str
  end,
  searchcount = function(str, _)
    component_lengths.right.searchcount = #str + 1
    return str
  end,
  tabs = function(str, _)
    component_lengths.right.tabs = #str + 1
    return str
  end,
  progress = function(str, _)
    if #str == 4 then
      component_lengths.right.progress = #str + 1
    else
      component_lengths.right.progress = #str + 2
    end
    return str
  end,
}

M.opts = {
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      'alpha',
      'mason',
      'lazy',
      'TelescopePrompt',
    },
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = update_length.mode,
      },
    },
    lualine_b = {
      {
        macro_recording,
        fmt = update_length.macro_recording,
        cond = function()
          if vim.fn.reg_recording() == '' then
            component_lengths.left.macro_recording = 0
          end
          return vim.fn.reg_recording() ~= ''
        end,
        padding = { left = 1 },
      },
      {
        'hostname',
        fmt = update_length.hostname,
        cond = function()
          local enabled = os.getenv('SSH_CLIENT') ~= nil
          if not enabled then
            component_lengths.left.hostname = 0
          end
          return enabled
        end,
        padding = { left = 1 },
      },
      {
        'branch',
        fmt = update_length.branch,
        padding = { left = 1 },
        icon = '',
      },
    },
    lualine_c = {
      {
        'diff',
        fmt = update_length.diff,
        padding = { left = 1 },
        source = function()
          ---@diagnostic disable-next-line: undefined-field
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
      '%=',
      function() return center_cushion('left') end,
      {
        'filetype',
        icon_only = true,
        padding = 0,
      },
      {
        'filename',
        path = 1,
      },
      function() return center_cushion('right') end,
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        fmt = update_length.diagnostics,
        symbols = {
          error = ' ',
          warn = ' ',
          hint = ' ',
          info = ' ',
        },
        padding = { right = 1 },
      },
    },
    lualine_y = {
      {
        'searchcount',
        fmt = update_length.searchcount,
        cond = function()
          if vim.v.hlsearch == 0 then
            component_lengths.right.searchcount = 0
          end
          return vim.v.hlsearch ~= 0
        end,
        padding = { right = 1 },
      },
      {
        tabs,
        fmt = update_length.tabs,
        cond = function()
          local enabled = vim.fn.tabpagenr('$')
          if not enabled then
            component_lengths.right.tabs = 0
          end
          return enabled
        end,
        padding = { right = 1 },
      },
    },
    lualine_z = {
      {
        'progress',
        fmt = function(str, _)
          if #str == 3 and str ~= 'Top' and str ~= 'Bot' then
            str = ' ' .. str
          end
          return update_length.progress(str)
        end,
      },
    },
  },
}

M.config = function(_, opts)
  require('lualine').setup(opts)

  vim.api.nvim_create_autocmd('RecordingEnter', {
    callback = function()
      require('lualine').refresh({
        place = { 'statusline' },
      })
    end,
  })

  vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function()
      local timer = vim.loop.new_timer()
      if not timer then
        return
      end
      timer:start(
        50,
        0,
        vim.schedule_wrap(
          function()
            require('lualine').refresh({
              place = { 'statusline' },
            })
          end
        )
      )
    end,
  })

  vim.api.nvim_create_user_command(
    'ToggleDebugLualineCentering',
    function() debug_centering = not debug_centering end,
    {}
  )
end

return M
