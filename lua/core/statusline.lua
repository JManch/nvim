local M = {}

local events = {
  'WinEnter',
  'BufEnter',
  'SessionLoadPost',
  'FileChangedShellPost',
  'VimResized',
  'Filetype',
  'CursorMoved',
  'CursorMovedI',
  'ModeChanged',
}

local events_hash = {}
for i, v in ipairs(events) do
  events_hash[v] = i
end

local modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['ntT'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

local sides = {
  left = 0,
  right = 1,
  middle = 2,
}

local padding = {
  none = 0,
  left = 1,
  right = 2,
  both = 3,
  size = function(self, padding)
    if padding == self.none then
      return 0
    elseif padding == self.both then
      return 2
    else
      return 1
    end
  end,
}

-- TODO: Define highlight groups and store them in this table
-- I'm not sure if it's possible to create highlight group with lua...
-- Worse case scenario just use existing groups or create new ones in vimscript

-- local highlights = {
--   normal =
-- }

local mode = {
  name = 'mode',
  events = { 'ModeChanged' },
  side = sides.left,
  padding = padding.both,
  update = function(self)
    local new_mode = vim.api.nvim_get_mode().mode
    if new_mode == self.mode then
      return false
    end
    self.mode = new_mode
    self.raw = modes[self.mode] or self.mode
    self.length = #self.raw + padding:size(self.padding)
    return true
  end,
}

local filename = {
  name = 'filename',
  events = { 'BufEnter', 'WinEnter' },
  side = sides.right,
  padding = padding.both,
  update = function(self)
    local new_filename = vim.fn.expand('%')
    if new_filename == self.filename then
      return false
    end
    self.filename = new_filename
    self.raw = self.filename
    self.length = #self.raw + padding:size(self.padding)
    return true
  end,
}

local components = { event_cache = {} }
setmetatable(components, {
  __newindex = function(self, _, component)
    for _, event in ipairs(component.events) do
      if self.event_cache[event] == nil then
        self.event_cache[event] = {}
      end
      table.insert(self.event_cache[event], component.name)
      rawset(self, component.name, component)
    end
  end,
  __index = function(self, key)
    if events_hash[key] ~= nil and self.event_cache[key] ~= nil then
      local event_components = {}
      for _, name in ipairs(self.event_cache[key]) do
        table.insert(event_components, rawget(self, name))
      end
      return event_components
    else
      return rawget(self, key)
    end
  end,
})

local lengths = {
  left = 0,
  right = 0,
  add = function(self, component)
    -- Add a components length
    if component.length == nil then
      return
    elseif component.side == sides.left then
      self.left = self.left + component.length
    elseif component.side == sides.right then
      self.right = self.right + component.length
    end
  end,
  -- Subtract a components length
  sub = function(self, component)
    if component.length == nil then
      return
    elseif component.side == sides.left then
      self.left = self.left - component.length
    elseif component.side == sides.right then
      self.right = self.right - component.length
    end
  end,
}

local update_component = function(component)
  lengths:sub(component)
  local changed = component:update()
  lengths:add(component)
  if changed then
    -- Update the components value using the raw value
    local strings = {}

    if component.highlight ~= nil then
      table.insert(strings, table.concat({ '%#', component.highlight, '#' }))
    end

    if component.padding == padding.left or component.padding == padding.both then
      table.insert(strings, ' ')
    end

    table.insert(strings, component.raw)

    if component.padding == padding.right or component.padding == padding.both then
      table.insert(strings, ' ')
    end

    component.value = table.concat(strings)
  end
end

local load_statusline = function()
  vim.notify('loading statusline')
  components.mode = mode
  components.filename = filename
end

local update_statusline = function(event)
  local start = vim.loop.hrtime()
  local event_components = components[event]
  if event_components == nil then
    return
  end
  for _, component in ipairs(event_components) do
    update_component(component)
  end

  -- Construct the statusline
  local statusline = table.concat({
    components.mode.value,
    components.filename.value,
  })

  vim.api.nvim_set_option('statusline', statusline)
  print('Statusline update took ' .. (vim.loop.hrtime() - start) / 1000)
end

vim.api.nvim_create_autocmd(events, {
  group = vim.api.nvim_create_augroup('Statusline', {}),
  callback = function(tbl) update_statusline(tbl.event) end,
})

load_statusline()

return M
