-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Common Keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set({ "n", "v" }, "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", noremap = true })

-- Neotest Keymaps
local neotest = require("neotest")
keymap.set("n", "<leader>tt", function()
  neotest.run.run()
end, { desc = "Run nearest test" })

keymap.set("n", "<leader>tf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run test in file" })

keymap.set("n", "<leader>ts", function()
  neotest.summary.toggle()
end, { desc = "Toggle test summary" })

keymap.set("n", "<leader>to", function()
  neotest.output.open({ enter = true })
end, { desc = "Show test output" })
