return {
	"ThePrimeagen/harpoon",
	config = true,
	init = function()
		-- use control instead of leader because of how important this is
		vim.keymap.set("n", "<leader>a", function()
			require("harpoon.mark").add_file()
		end, { desc = "[A]dd file to harpoon" })
		vim.api.nvim_create_user_command("Harpoon", function()
			require("harpoon.ui").toggle_quick_menu()
		end, { desc = "Open Harpoon Menu" })
		for i = 1, 5 do
			vim.keymap.set("n", string.format("<leader>%d", i), function()
				require("harpoon.ui").nav_file(i)
			end, { desc = string.format("Navigate to harpooned file %d", i) })
		end
	end,
}
