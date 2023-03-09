return {
	{
		"mfussenegger/nvim-dap",
		init = function()
			local dap = require("lazy-require").require_on_exported_call("dap")

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				local condition = vim.fn.input("Breakpoint Condition: ")
				if condition then
					dap.set_breakpoint(condition)
				end
			end, { desc = "DAP: Set conditional breakpoint" })
			vim.keymap.set("n", "<leader>dl", function()
				local log_message = vim.fn.input("Log message: ")
				if log_message then
					dap.set_breakpoint(log_message)
				end
			end, { desc = "DAP: Set log point" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })

			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP: Step over" })
			vim.keymap.set("n", "<leader>dt", dap.run_to_cursor, { desc = "DAP: Run to cursor" })
		end,
		config = function()
			local dap = require("dap")

			dap.adapters.netcoredbg = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
				-- TODO: we need vsda for this one, apparently it is some closed source visual studio stuff
				-- command = "/Users/jmederos/.vscode/extensions/ms-dotnettools.csharp-1.25.2-darwin-arm64/.debugger/arm64/vsdbg-ui",
				id = "coreclr",
			}
			dap.adapters.coreclr = dap.adapters.netcoredbg

			dap.configurations.cs = {
				{
					type = "netcoredbg",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						local selected
						vim.ui.select(vim.fn.glob(vim.fn.getcwd() .. "/bin/Debug/**/*.dll", true, true), {
							prompt = "Select a program to debug",
							format_item = function(item)
								return vim.fn.fnamemodify(item, ":~:.")
							end,
						}, function(choice)
							selected = choice
						end)
						return selected
					end,
					stopAtEntry = true,
				},
			}

			local dapui = require("lazy-require").require_on_exported_call("dapui")

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			-- dap.listeners.after.event_terminated["dapui_config"] = dapui.close
			-- dap.listeners.after.event_exited["dapui_config"] = dapui.close
		end,
	},

	{ "rcarriga/nvim-dap-ui", config = true },
	{ "theHamsta/nvim-dap-virtual-text", config = true },
}
