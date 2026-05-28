vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

keymap.set("n", "gd", vim.lsp.buf.definition)
keymap.set("n", "gr", vim.lsp.buf.references)
keymap.set("n", "K", vim.lsp.buf.hover)

keymap.set("n", "<leader>e", vim.diagnostic.open_float)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>")
vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>")
vim.keymap.set("n", "<leader>ce", ":CopilotChatExplain<CR>")
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>")
vim.keymap.set("n", "<leader>ct", ":CopilotChatTests<CR>")
vim.keymap.set("v", "<leader>ct", ":CopilotChatTests<CR>")
