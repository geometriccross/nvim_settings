return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4.5"
				},
				tools = {
					opts = {
						auto_submit_errors = true,
						auto_submit_success = true
					}
				},
				complemention_provider = "cmp",
				roles = {
					---The header name for the LLM's messages
					---@type string|fun(adapter: CodeCompanion.Adapter): string
					llm = function(adapter)
						return "🤖 (" .. adapter.model.name .. ")"
					end,
					user = "Me"
				}
			},
		},
		display = {
			chat = {
				intro_message = "こんにちは! どのようにお手伝いできますか？",
				separator = "-",
				show_header_separator = true
			}
		},
		opts = {
			language = "Japanese",
			complemention_provider = "cmp",
			---Decorate the user message before it's sent to the LLM
			---@param message string
			---@param adapter CodeCompanion.Adapter
			---@param context table
			---@return string
			prompt_decorator = function(message, adapter, context)
				return string.format([[<prompt>%s</prompt>]], message)
			end,
		}
	}
}
