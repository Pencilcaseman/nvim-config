local function format(component, text, hl_group)
  if not hl_group then
    return text
  end

  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require 'lualine.utils.utils'
    local mygui = function()
      local mybold = utils.extract_highlight_colors(hl_group, 'bold') and 'bold'
      local myitalic = utils.extract_highlight_colors(hl_group, 'italic') and 'italic'
      if mybold and myitalic then
        return mybold .. ',' .. myitalic
      elseif mybold then
        return mybold
      elseif myitalic then
        return myitalic
      else
        return ''
      end
    end

    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, 'fg'),
      gui = mygui(),
    }, 'LV_' .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

local function selection_count()
  if vim.fn.mode():find '[vV]' then
    local counts = vim.fn.wordcount()

    local starts = vim.fn.line 'v'
    local ends = vim.fn.line '.'
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1

    return string.format('L:%d W:%d C:%d', lines, counts.visual_words, counts.visual_chars)
  else
    return ''
  end
end

local function pretty_path(opts)
  opts = vim.tbl_extend('force', {
    modified_hl = 'NeogitGraphBoldYellow',
    filename_hl = 'NeogitGraphBoldWhite',
    dirpath_hl = 'Conceal',
  }, opts or {})

  return function(self)
    local path = vim.fn.expand '%:p' --[[@as string]]
    if path == '' then
      return ''
    end

    local cwd = vim.fn.getcwd()
    path = path:sub(#cwd + 2)

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, '[\\/]')

    if #parts > 3 then
      parts = { parts[1], '…', parts[#parts - 1], parts[#parts] }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = format(self, parts[#parts], opts.modified_hl)
    else
      parts[#parts] = format(self, parts[#parts], opts.filename_hl)
    end

    local dirpath = ''
    if #parts > 1 then
      dirpath = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dirpath = format(self, dirpath .. sep, opts.dirpath_hl)
    end
    return dirpath .. parts[#parts]
  end
end

return {
  'nvim-lualine/lualine.nvim',

  event = 'LazyFile',

  dependencies = {
    'yavorski/lualine-macro-recording.nvim',
  },
  opts = {
    icons_enabled = vim.g.have_nerd_font,

    theme = 'monokai-pro',

    extensions = {
      'fzf',
      'mason',
      'nvim-dap-ui',
      'overseer',
      'toggleterm',
    },

    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            -- Formats as:
            -- NORMAL => NOR
            -- INSERT => INS
            -- VISUAL => VIS
            return str:sub(1, 3)
          end,
        },
      },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      -- lualine_c = { 'filename', 'macro_recording' },
      lualine_c = { {
        pretty_path { filename_hl = 'Bold', modified_hl = 'MatchParen' },
      }, 'macro_recording' },
      lualine_x = { selection_count, 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  },

  config = function(_, opts)
    require('lualine').setup(opts)
  end,
}
