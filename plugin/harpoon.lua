vim.keymap.set("n", "<C-a>", function()
  require("harpoon"):list():add()
end, { desc = "[A]dd file to harpoon" })

vim.keymap.set("n", "<C-f>", function()
  require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Toggle harpoon quick menu" })

vim.keymap.set("n", "<C-j>", function()
  require("harpoon"):list():select(1)
end, { desc = "Switch to harpoon file 1" })

vim.keymap.set("n", "<C-k>", function()
  require("harpoon"):list():select(2)
end, { desc = "Switch to harpoon file 2" })

vim.keymap.set("n", "<C-l>", function()
  require("harpoon"):list():select(3)
end, { desc = "Switch to harpoon file 3" })

vim.keymap.set("n", "<C-;>", function()
  require("harpoon"):list():select(4)
end, { desc = "Switch to harpoon file 4" })

require("harpoon"):setup({})
