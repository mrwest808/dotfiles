-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap

map.set("n", "<C-d>", "5<C-e>")
map.set("n", "<C-u>", "5<C-y>")

-- Move lines up/down
map.set({ "n", "v" }, "ª", "<Cmd>move-2<CR>")
map.set({ "n", "v" }, "√", "<Cmd>move+<CR>")
map.del({ "i", "n", "v" }, "<M-k>")
map.del({ "i", "n", "v" }, "<M-j>")

-- Yank to / paste from system clipboard
map.set({ "n", "v" }, "<leader>y", '"*y', { desc = "Yank to system clipboard" })
map.set({ "n", "v" }, "<leader>p", '"*p', { desc = "Paste from system clipboard" })

-- Ensure ctrl+space opens completions
-- The ctrl+space keypress doesn't always register, not sure if related
-- to Alacritty or tmux yet..
local present, cmp = pcall(require, "cmp")
if present then
  map.set("i", " ", cmp.mapping.complete()) -- alt+space
  map.set("i", "<c-space>", cmp.mapping.complete())
end

--
-- Plugin mappings that I haven't been able to override in ../plugins
--

-- [Bufferline]

-- ~Close other buffers
map.set(
  "n",
  "<leader>bb",
  "<Cmd>BufferLineCloseLeft<CR> <Bar> <Cmd>BufferLineCloseRight<CR>",
  { desc = "Close others" }
)

-- Additional prev/next buffer mappings
map.set("n", "<Left>b", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map.set("n", "<Right>b", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

-- [vim-easy-align]

map.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
