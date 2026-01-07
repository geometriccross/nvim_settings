return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		interactions = {
			chat = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4.5",
				},
				roles = {
					---The header name for the LLM's messages
					---@type string|fun(adapter: CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter): string
					llm = function(adapter)
						return "🤖 (" .. adapter.formatted_name .. ")"
					end,
					user = "Me",
				},
				tools = {
					["web_search"] = {
						callback = "interactions.chat.tools.builtin.web_search",
						description = "Web上の情報を検索します",
						opts = {
							adapter = "tavily",
							opts = {
								search_depth = "advanced", -- "basic" または "advanced"
							},
						},
					},
					opts = {
						system_prompt = {
							enabled = true,
							replace_main_system_prompt = false,
							prompt = function(args)
								return [[
ROLE — Strategic collaborator. Improve clarity, rigor, and impact; don't agree by default or posture as authority.
CORE — Challenge with respect; evidence-first (logic > opinion); synthesize to key variables & 2nd-order effects; end with prioritized next steps/decision paths.
FRAMEWORK (silent) — 1) clarify ask/outcome 2) note context/constraints 3) consider multiple angles 4) apply clear logic 5) deliver concise, forward-looking synthesis.
RULes — If ambiguous: ask 1 clarifying Q (max 2 if essential). Always do steps 1–2; scale others. No background/async claims. No chain-of-thought; use brief audit summaries only.
VOICE — Clear, candid, peer-like; no fluff/cheerleading.
DISAGREEMENT — State plainly → why (assumptions/evidence) → better alternative or sharper question.
OUTPUT — 1) Situation 2) Assumptions/Constraints 3) Options/Trade-offs 4) Recommendation 5) Next Actions 6) Risks 7) Open Questions.
AUDIT — On "audit", return: Ask & Outcome; Constraints/Context; Angles; Logic path; Synthesis (fit to goal).
COMMANDS — audit.
HEURISTICS — Prefer principles > opinions; surface uncertainties, thresholds, risks, missing data.
								]]
							end,
						},
					},
				},
			},
		},
		display = {
			chat = {
				intro_message = "こんにちは! どのようにお手伝いできますか？",
				separator = "-",
				show_header_separator = true,
				icons = {
					chat_context = "📎️", -- You can also apply an icon to the fold
				},
				fold_context = true,
			},
			diff = {
				provider_opts = {
					inline = {
						layout = "buffer", -- float|buffer - Where to display the diff
						opts = {
							context_lines = 3, -- Number of context lines in hunks
							dim = 25, -- Background dim level for floating diff (0-100, [100 full transparent], only applies when layout = "float")
							full_width_removed = true, -- Make removed lines span full width
							show_keymap_hints = true, -- Show "gda: accept | gdr: reject" hints above diff
							show_removed = true, -- Show removed lines as virtual text
						},
					},
				},
			},
		},
		opts = {
			language = "Japanese",
		},
		prompt_library = {
			markdown = {
				dirs = {
					vim.fn.getcwd() .. "/.doc",
					vim.fn.getcwd() .. "/.prompts",
					vim.fn.getcwd() .. "/.doc/prompts",
					"~/.dotfiles/.config/prompts",
				}
			}
		},
	},
}
