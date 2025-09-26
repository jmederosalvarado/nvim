--- @type LazySpec
return {
  "dmtrKovalenko/fff.nvim",
  enabled = false,
  build = "cargo build --release",
  opts = {
    prompt = "❯ ",
  },
  keys = {
    {
      "ff", -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_files() -- or find_in_git_root() if you only want git files
      end,
      desc = "Open file picker",
    },
  },
}
