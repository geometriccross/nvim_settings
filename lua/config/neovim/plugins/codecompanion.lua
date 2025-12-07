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
					model = "claude-sonnet-4.5",
				},
				tools = {
					["web_search"] = {
						callback = "strategies.chat.tools.catalog.web_search",
						description = "Web上の情報を検索します",
						opts = {
							adapter = "tavily",
							opts = {
								search_depth = "advanced", -- "basic" または "advanced"
							},
						},
					},
				},
				roles = {
					---The header name for the LLM's messages
					---@type string|fun(adapter: CodeCompanion.Adapter): string
					llm = function(adapter)
						return "🤖 (" .. adapter.model.name .. ")"
					end,
					user = "Me",
				},
				system_prompt = function(ctx)
					return ctx.default_system_prompt
						.. "\n\n"
						.. [[
ROLE — Strategic collaborator. Improve clarity, rigor, and impact; don’t agree by default or posture as authority.
CORE — Challenge with respect; evidence-first (logic > opinion); synthesize to key variables & 2nd-order effects; end with prioritized next steps/decision paths.
FRAMEWORK (silent) — 1) clarify ask/outcome 2) note context/constraints 3) consider multiple angles 4) apply clear logic 5) deliver concise, forward-looking synthesis.
RULes — If ambiguous: ask 1 clarifying Q (max 2 if essential). Always do steps 1–2; scale others. No background/async claims. No chain-of-thought; use brief audit summaries only.
VOICE — Clear, candid, peer-like; no fluff/cheerleading.
DISAGREEMENT — State plainly → why (assumptions/evidence) → better alternative or sharper question.
OUTPUT — 1) Situation 2) Assumptions/Constraints 3) Options/Trade-offs 4) Recommendation 5) Next Actions 6) Risks 7) Open Questions.
AUDIT — On “audit”, return: Ask & Outcome; Constraints/Context; Angles; Logic path; Synthesis (fit to goal).
COMMANDS — audit.
HEURISTICS — Prefer principles > opinions; surface uncertainties, thresholds, risks, missing data.
						]]
				end,
			},
		},
		display = {
			chat = {
				intro_message = "こんにちは! どのようにお手伝いできますか？",
				separator = "-",
				show_header_separator = true,
			},
		},
		opts = {
			language = "Japanese",
			complemention_provider = "blink",
			---Decorate the user message before it's sent to the LLM
			---@param message string
			---@param adapter CodeCompanion.Adapter
			---@param context table
			---@return string
			prompt_decorator = function(message, adapter, context)
				return string.format([[<prompt>%s</prompt>]], message)
			end,
		},
	},
}
