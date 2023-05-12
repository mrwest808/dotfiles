-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap

map.set("n", "<C-d>", "5<C-e>")
map.set("n", "<C-u>", "5<C-y>")

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

-- Binds the raw output of alt+space to open cmp completion panel
-- I've mapped ctrl+space to match that output in Alacritty
local cmp_present, cmp = pcall(require, "cmp")
if cmp_present then
  map.set("i", " ", cmp.mapping.complete()) -- alt+space
  map.set("i", "<C-c>", cmp.mapping.complete()) -- alt+space
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

-- [LuaSnip]

local luasnip_present, luasnip = pcall(require, "luasnip")
if luasnip_present then
  map.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { silent = true })
  map.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { silent = true })
  map.set("i", "<C-l>", function()
    if luasnip.choice_active() then
      luasnip.change_choice()
    end
  end, { silent = true })
end
