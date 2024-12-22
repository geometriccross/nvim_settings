return {
	'zbirenbaum/copilot.lua',
	dependencies = {
		{
			'zbirenbaum/copilot-cmp',
			config = true
		},
		'CopilotC-Nvim/CopilotChat.nvim',
	},
	suggestion = { enabled = false },
	panel = { enabled = false },
	copilot_node_command = 'node',
	config = function ()
		require('copilot').setup({})
	end,

	-- lazy loading
	event = 'InsertEnter',
	cmd = 'Copilot'
}
