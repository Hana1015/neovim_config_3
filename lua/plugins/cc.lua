return {
 {
 'CopilotC-Nvim/CopilotChat.nvim',
 dependencies = {
 { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
 { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
 },
 build = 'make tiktoken',
 opts = {
 -- See Configuration section for options
 },
 -- See Commands section for default commands if you want to lazy load on them
 config = function()
 require('CopilotChat').setup({
 model = 'GPT-5.2-codex',
 prompts = {
 Explain = {
 prompt = '選択したコードの説明を日本語で書いてください',
 mapping = '<leader>ce',
 },
 Review = {
 prompt = 'コードを日本語でレビューしてください',
 mapping = '<leader>cr',
 },
 Fix = {
 prompt = 'このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします',
 mapping = '<leader>cf',
 },
 Optimize = {
 prompt = '選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします',
 mapping = '<leader>co',
 },
 Docs = {
 prompt = '選択したコードに関するドキュメントコメントを日本語で生成してください',
 mapping = '<leader>cd',
 },
 Tests = {
 prompt = '選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします',
 mapping = '<leader>ct',
 },
 Commit = {
 prompt = require('CopilotChat.config.prompts').Commit.prompt,
 mapping = '<leader>cco',
 selection = require('CopilotChat.select').gitdiff,
 },
 },
 mappings = {
 accept_diff = {
 normal = '<leader>ca',
 insert = '<leader>ca',
 },
 },
 })
 end,  -- See Commands section for default commands if you want to lazy load on them
 keys = {
 {
 '<leader>cc',
 function()
 require('CopilotChat').toggle()
 end,
 desc = 'CopilotChat - Toggle',
 },
 {
 '<leader>cch',
 function()
 local actions = require('CopilotChat.actions')
 require('CopilotChat.integrations.telescope').pick(actions.help_actions())
 end,
 desc = 'CopilotChat - Help actions',
 },
 { '<leader>ccp',
 function()
 local actions = require('CopilotChat.actions')
 require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
 end,
 desc = 'CopilotChat - Prompt actions',
 },
 },
 },
}