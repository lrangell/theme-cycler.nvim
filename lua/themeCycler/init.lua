local default_themes = (require("themeCycler.utils"))["default-themes"]
local popup_options = (require("themeCycler.utils"))["popup-options"]
local file_path = (require("themeCycler.utils"))["file-path"]
do local _ = {nil, nil, nil} end
local config = {["popup-options"] = popup_options, blacklist = {}, blacklist_default = true}
local function blacklisted(theme)
  return not vim.tbl_contains(vim.tbl_flatten(config.blacklist), theme)
end
local function themes()
  return vim.tbl_filter(blacklisted, vim.fn.getcompletion("", "color"))
end
local function render(colorschemes)
  local bufn = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufn, 0, -1, false, colorschemes)
  vim.api.nvim_open_win(bufn, true, vim.tbl_extend("force", config["popup-options"], {height = #colorschemes}))
  return bufn
end
local function write_theme(colorschemes)
  vim.fn.writefile({colorschemes[vim.fn.getcurpos()[2]]}, file_path, "s")
  return vim.api.nvim_win_close(0, false)
end
local function set_theme(colorschemes)
  return vim.cmd.colorscheme(colorschemes[vim.fn.getcurpos()[2]])
end
local function open()
  local colorschemes = themes()
  local buffer = render(colorschemes)
  local function _1_()
    return write_theme(colorschemes)
  end
  vim.keymap.set("n", "<CR>", _1_, {buffer = buffer})
  local function _2_()
    return write_theme(colorschemes)
  end
  vim.keymap.set("n", "l", _2_, {buffer = buffer})
  local function _3_()
    return set_theme(colorschemes)
  end
  return vim.api.nvim_create_autocmd({"CursorMoved"}, {buffer = buffer, callback = _3_})
end
local function restore()
  return vim.cmd.colorscheme(vim.fn.readfile(file_path)[1])
end
local function setup(_4_)
  local _arg_5_ = _4_
  local blacklist = _arg_5_["blacklist"]
  local blacklist_default = _arg_5_["blacklist_default"]
  vim.api.nvim_create_augroup("restore_theme", {clear = true})
  vim.api.nvim_create_autocmd({"VimEnter"}, {group = "restore_theme", pattern = "*", callback = restore, nested = true})
  local function _6_()
    if ((nil == blacklist_default) or blacklist_default) then
      return default_themes
    else
      return {}
    end
  end
  config = vim.tbl_extend("force", config, {blacklist = {(blacklist or {}), _6_()}})
  return nil
end
local timer = vim.loop.new_timer()
timer:start(300, 0, vim.schedule_wrap(restore))
setup({})
setup({blacklist = {"catppuccin-latte", "minicyan", "minischeme"}})
local function _7_()
  return open()
end
return {open = open, open_lazy = _7_}