return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			language = "Japanese",
			log_level = "DEBUG", -- or "TRACE"
			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
			},
			adapters = {
				-- copilotアダプタを上書き
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-4.5-sonnet",
							},
						},
					})
				end,
			},
		},
	},
}
