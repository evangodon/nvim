local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

function M.config()
	local wk = require "which-key"
	wk.setup({
		plugins = {
			marks = false, -- Disable marks since it doesn't respect timeoutlen
			spelling = {
				enabled = true,
				suggestions = 20,
			},
		},
	})
end

return M
