return {
	"hedyhli/outline.nvim",
	keys = { { "<leader>o", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
	cmd = "Outline",
	opts = function()
		local defaults = require("outline.config").defaults
	end,
}
