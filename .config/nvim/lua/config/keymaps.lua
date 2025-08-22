-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap

-- Up/down navigation
map.set("n", "<C-d>", "5<C-e>")
map.set("n", "<C-u>", "5<C-y>")

-- Increment / decrement numbers
map.set("n", "<leader>nd", "<C-a>")
map.set("n", "<leader>ni", "<C-x>")

-- Move lines up/down
map.set("n", "√", "<cmd>m .+1<cr>==", { desc = "Move down" })
map.set("n", "ª", "<cmd>m .-2<cr>==", { desc = "Move up" })
map.set("i", "√", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map.set("i", "ª", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map.set("v", "√", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map.set("v", "ª", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map.del({ "i", "n", "v" }, "<M-k>")
map.del({ "i", "n", "v" }, "<M-j>")

-- Yank to / paste from system clipboard
map.set({ "n", "v" }, "<leader>y", '"*y', { desc = "Yank to system clipboard" })
map.set({ "n", "v" }, "<leader>p", '"*p', { desc = "Paste from system clipboard" })

-- [bufferline.nvim]

-- -> Close other buffers
map.set(
  "n",
  "<leader>bb",
  "<Cmd>BufferLineCloseLeft<CR> <Bar> <Cmd>BufferLineCloseRight<CR>",
  { desc = "Close others" }
)

-- [LazyVim]

local LazyVim = require("lazyvim.util")
local Snacks = require("snacks")

map.set("n", "<C-p>", LazyVim.pick("files", { cwd = LazyVim.root.get(), show_untracked = true }))
map.set("n", "<S-Esc>", Snacks.zen.zoom)

-- [copilot.lua]

map.set("i", "<M-Right>", function()
  require("copilot.suggestion").next()
  -- Make sure to close autocomplete menu
  require("blink.cmp").hide()
end)
map.set("i", "<M-Left>", function()
  require("copilot.suggestion").prev()
  -- Make sure to close autocomplete menu
  require("blink.cmp").hide()
end)
map.set("i", "<M-Enter>", function()
  require("copilot.suggestion").accept()
end)
