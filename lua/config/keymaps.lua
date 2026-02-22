-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Common Keymaps
local keymap = vim.keymap
local map = vim.keymap.set

keymap.set({ "n", "v" }, "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", noremap = true })
keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<leader>dd", function()
	Snacks.terminal("lazydocker", { win = { style = "terminal" } })
end, { desc = "LazyDocker (Docker 관리)" })
