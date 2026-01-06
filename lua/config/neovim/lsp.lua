-- ============================================================================
-- LSP Configuration
-- ============================================================================
-- This file contains all LSP-related configurations including:
-- 1. Plugin definitions (Mason, Mason-lspconfig, nvim-lspconfig)
-- 2. LSP server installations and settings
-- 3. Keymaps and autocommands
-- 4. Diagnostic settings
-- ============================================================================

-- ============================================================================
-- 1. Plugin Definitions and Setup
-- ============================================================================

-- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
require("mason").setup()

-- Mason-lspconfig: Bridge between mason.nvim and nvim-lspconfig
local ensure_installed = { "bashls", "lua_ls", "powershell_es", "copilot" }

require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = ensure_installed,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

-- ============================================================================
-- 2. LSP Server Configurations
-- ============================================================================

local nvim_lsp = require("lspconfig")

-- PowerShell Language Server
vim.lsp.config("powershell_es", {
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
	filetypes = { "ps1", "psm1", "psd1" },
	bundle_path = vim.fn.expand(vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"),
	settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
})

-- Racket Language Server
vim.lsp.config("racket_langserver", {
	cmd = { "racket", "--lib", "racket-langserver" },
	filetypes = { "racket", "rkt" },
	root_dir = nvim_lsp.util.root_pattern("info.rkt", ".git") or nvim_lsp.util.path.dirname,
	settings = {},
})

-- ============================================================================
-- 3. Diagnostic Settings
-- ============================================================================

-- Global diagnostic keymaps
-- See `:help vim.diagnostic.*` for documentation
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set diagnostic loclist" })

-- ============================================================================
-- 4. LSP Attach Autocommand and Buffer Keymaps
-- ============================================================================

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- If using nvim-cmp or blink-cmp, omnifunc response is overridden,
		-- so the below line is not necessary
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		-- Hover and signature help
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("force", opts, { desc = "LSP Signature Help" })
		)

		-- Workspace management
		vim.keymap.set(
			"n",
			"<space>wa",
			vim.lsp.buf.add_workspace_folder,
			vim.tbl_extend("force", opts, { desc = "Add workspace folder" })
		)
		vim.keymap.set(
			"n",
			"<space>wr",
			vim.lsp.buf.remove_workspace_folder,
			vim.tbl_extend("force", opts, { desc = "Remove workspace folder" })
		)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

		-- Code actions
		vim.keymap.set(
			"n",
			"<space>rn",
			vim.lsp.buf.rename,
			vim.tbl_extend("force", opts, { desc = "LSP Rename" })
		)
		vim.keymap.set(
			"n",
			"<space>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "LSP Code Action" })
		)
	end,
})

-- ============================================================================
-- 5. Enable LSP Servers
-- ============================================================================

vim.lsp.enable(ensure_installed)
