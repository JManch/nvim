local M = {}

local api = vim.api
local fn = vim.fn

M.set_highlights = function()
  api.nvim_set_hl(0, 'MatchParen', { link = 'Constant' })
  api.nvim_set_hl(0, 'NoCursor', { blend = 100, strikethrough = true })

  -- Missing highlight groups from ayu
  api.nvim_set_hl(0, 'Bold', { bold = true })
  api.nvim_set_hl(0, 'Italic', { italic = true })
  api.nvim_set_hl(0, '@text.strong', { link = 'Bold' })
  api.nvim_set_hl(0, '@text.emphasis', { link = 'Italic' })
end

local jump_chars = {
  ['('] = true,
  [')'] = true,
  ['['] = true,
  [']'] = true,
  ['{'] = true,
  ['}'] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
  ['<'] = true,
  ['>'] = true,
  [','] = true,
  ['.'] = true,
}

M.bracket_jump = function()
  local cur_pos = api.nvim_win_get_cursor(0)
  local row = cur_pos[1]
  local col = cur_pos[2]
  local line = api.nvim_get_current_line()
  local sub_line = line:sub(col + 1, #line)

  local jumped = false
  for c in sub_line:gmatch('.') do
    col = col + 1
    if jump_chars[c] ~= nil then
      jumped = true
      api.nvim_win_set_cursor(0, { row, col })
      break
    end
  end
  if not jumped then
    api.nvim_win_set_cursor(0, { row, #line })
  end
end

M.delete_hidden_buffers = function()
  local buffers = api.nvim_list_bufs()
  local ok
  for _, buf in ipairs(buffers) do
    local buf_info = vim.fn.getbufinfo(buf)[1]
    if buf_info.loaded == 0 or (buf_info.hidden == 1 and buf_info.listed == 1) then
      ---@diagnostic disable-next-line: cast-local-type
      ok, _ = pcall(api.nvim_buf_delete, buf, { force = false })
      if not ok then
        vim.cmd.b(buf)
        return
      end
    end
  end
  vim.notify('Closed all background buffers', vim.log.levels.INFO, { title = 'Buffers' })
end

local toggle_table_key = function(table, key, on, off)
  if table[key] ~= off then
    table[key] = off
  else
    table[key] = on
  end
end

M.toggle_g = function(key, on, off)
  toggle_table_key(vim.g, key, on, off)
end

M.toggle_o = function(key, on, off)
  toggle_table_key(vim.o, key, on, off)
end

M.toggle_wo = function(key, on, off)
  toggle_table_key(vim.wo, key, on, off)
end

M.toggle_local_opt = function(key, value)
  if vim.opt_local[key]:get()[value] == nil then
    vim.opt_local[key]:append(value)
  else
    vim.opt_local[key]:remove(value)
  end
end

M.set_alacritty_theme = function(is_day)
  if vim.fn.has('win32') ~= 1 or os.getenv('ALACRITTY') ~= 'true' then
    return
  end
  if is_day then
    vim.fn.jobstart(
      [[sed -i "s/colors: \*dark/colors: *light/" ]] .. os.getenv('APPDATA') .. '\\alacritty\\alacritty.yml'
    )
  else
    vim.fn.jobstart(
      [[sed -i "s/colors: \*light/colors: *dark/" ]] .. os.getenv('APPDATA') .. '\\alacritty\\alacritty.yml'
    )
  end
end

P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(module)
  require('plenary.reload').reload_module(module)
  return require(module)
end

return M
