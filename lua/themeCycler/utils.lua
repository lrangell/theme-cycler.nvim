local default_themes = {"blue", "darkblue", "default", "delek", "desert", "elflord", "evening", "habamax", "industry", "koehler", "lunaperche", "morning", "murphy", "pablo", "peachpuff", "quiet", "ron", "shine", "slate", "torte", "zellner"}
local popup_options = {relative = "cursor", width = 20, row = 5, col = 5, style = "minimal", border = "shadow"}
local file_path = (vim.fn.stdpath("data") .. "/themeCycler.txt")
return {["default-themes"] = default_themes, ["popup-options"] = popup_options, ["file-path"] = file_path}
