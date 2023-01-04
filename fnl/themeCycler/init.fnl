(import-macros {: import : def : import-from} :macros)
(import-from [default-themes popup-options file-path] :themeCycler.utils)

(var config {: popup-options :blacklist [] :blacklist_default true})

(fn blacklisted [theme]
  (not (vim.tbl_contains (vim.tbl_flatten config.blacklist) theme)))

(fn themes []
  (vim.tbl_filter blacklisted (vim.fn.getcompletion "" :color)))

(fn render [colorschemes]
  (let [bufn (vim.api.nvim_create_buf false true)]
    (vim.api.nvim_buf_set_lines bufn 0 -1 false colorschemes)
    (vim.api.nvim_open_win bufn true
                           (vim.tbl_extend :force config.popup-options
                                           {:height (length colorschemes)}))
    bufn))

(fn write-theme [colorschemes]
  (vim.fn.writefile [(. colorschemes (. (vim.fn.getcurpos) 2))] file-path :s)
  (vim.api.nvim_win_close 0 false))

(fn set-theme [colorschemes]
  (-> colorschemes (. (. (vim.fn.getcurpos) 2)) (vim.cmd.colorscheme)))

(fn open []
  (let [colorschemes (themes)
        buffer (render colorschemes)]
    (vim.keymap.set :n :<CR> #(write-theme colorschemes) {: buffer})
    (vim.keymap.set :n :l #(write-theme colorschemes) {: buffer})
    (vim.api.nvim_create_autocmd [:CursorMoved]
                                 {: buffer :callback #(set-theme colorschemes)})))

(fn restore []
  (let [(ok file) (pcall vim.fn.readfile file-path)]
    (when ok
      (vim.cmd.colorscheme (. file 1)))))

(fn setup [{: blacklist : blacklist_default}]
  (set config (vim.tbl_extend :force config
                              {:blacklist [(or blacklist [])
                                           (if (or (= nil blacklist_default)
                                                   blacklist_default)
                                               default-themes
                                               [])]})))

(def timer (vim.loop.new_timer))
(timer:start 300 0 (vim.schedule_wrap restore))

(setup {})
(setup {:blacklist [:catppuccin-latte :minicyan :minischeme]})

{: open :open_lazy #(open)}
