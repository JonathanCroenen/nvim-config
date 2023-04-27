local M = {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
}

function M.config()
	local symbols = require("config.symbols")
	local stages_util = require("notify.stages.util")

	require("notify").setup({
		stages = {
			function(state)
				local next_height = state.message.height + 2
				local next_row =
					stages_util.available_slot(
                    state.open_windows,
                    next_height,
                    stages_util.DIRECTION.TOP_DOWN
                )
				if not next_row then
					return nil
				end
				return {
					relative = "editor",
					anchor = "NE",
					width = state.message.width,
					height = state.message.height,
					col = vim.opt.columns:get(),
					row = next_row,
					border = "rounded",
					style = "minimal",
					opacity = 0,
				}
			end,
			function()
				return {
					opacity = { 100 },
					col = { vim.opt.columns:get() },
				}
			end,
			function(state, win)
                return {
                    row = {
                        stages_util.slot_after_previous(
                            win,
                            state.open_windows,
                            stages_util.DIRECTION.TOP_DOWN
                        ),
                        frequency = 3,
                        complete = function()
                            return true
                        end,
                    },
                    col = { vim.opt.columns:get() },
                    time = true,
                }
            end,
			function()
				return {
					opacity = {
						0,
						frequency = 2,
						complete = function(cur_opacity)
							return cur_opacity <= 4
						end,
					},
					col = { vim.opt.columns:get() },
				}
			end,
		},
		timeout = 3000,
		icons = {
			ERROR = symbols.error,
			WARN = symbols.warn,
			INFO = symbols.info,
			DEBUG = symbols.debug,
			TRACE = symbols.trace,
		},
		render = "default",
		max_width = 50,
	})

	vim.api.nvim_set_hl(0, "NotifyERRORBorder", { link = "Error" })
	vim.api.nvim_set_hl(0, "NotifyWARNBorder", { link = "WarningMsg" })
	vim.api.nvim_set_hl(0, "NotifyINFOBorder", { link = "LspInfoList" })
	vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { link = "Debug" })
	vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { link = "Character" })

	vim.api.nvim_set_hl(0, "NotifyERRORIcon", { link = "Error" })
	vim.api.nvim_set_hl(0, "NotifyWARNIcon", { link = "WarningMsg" })
	vim.api.nvim_set_hl(0, "NotifyINFOIcon", { link = "LspInfoList" })
	vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { link = "Debug" })
	vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { link = "Character" })

	vim.api.nvim_set_hl(0, "NotifyERRORTitle", { link = "Error" })
	vim.api.nvim_set_hl(0, "NotifyWARNTitle", { link = "WarningMsg" })
	vim.api.nvim_set_hl(0, "NotifyINFOTitle", { link = "LspInfoList" })
	vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { link = "Debug" })
	vim.api.nvim_set_hl(0, "NotifyTRACETitle", { link = "Character" })

	vim.notify = require("notify")
end

return M
