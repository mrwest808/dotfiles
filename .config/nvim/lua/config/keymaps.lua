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

-- ["emmet expand abbreviation~"]

local function enter_normal_mode()
  local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(key, "n", false)
end

local function enter_insert_mode()
  vim.api.nvim_feedkeys("i", "n", true)
end

local function get_expandable_word_behind_cursor()
  local column_number = vim.fn.col(".")
  local line_number = vim.fn.line(".")
  local line_text = vim.fn.getline(line_number)
  ---@diagnostic disable-next-line: param-type-mismatch
  local text_before_cursor = string.sub(line_text, math.max(1, column_number - 40), column_number - 1)
  ---@diagnostic disable-next-line: param-type-mismatch
  local last_char = string.sub(line_text, column_number - 1, column_number - 1)

  if not last_char:match("[a-zA-Z_-]") then
    return nil
  end

  return string.match(text_before_cursor, "[a-zA-Z_-]+$")
end

function EmmetExpandAbbreviationSortOf()
  local current_word = get_expandable_word_behind_cursor()

  if current_word == nil or current_word == "" then
    return
  end

  enter_normal_mode()

  -- execute the "change inside word" motion
  vim.api.nvim_feedkeys("ciw", "n", true)

  -- insert the opening bracket
  vim.api.nvim_feedkeys("<", "n", true)

  -- move the cursor to the end of the word
  vim.api.nvim_feedkeys(current_word, "n", true)

  -- insert the closing bracket
  vim.api.nvim_feedkeys(">", "n", true)

  vim.api.nvim_feedkeys("</", "n", true)
  vim.api.nvim_feedkeys(current_word, "n", true)
  vim.api.nvim_feedkeys(">", "n", true)

  enter_normal_mode()

  vim.api.nvim_feedkeys("F<", "n", true)

  enter_insert_mode()
end

map.set("i", "<C-e>", "<cmd>lua EmmetExpandAbbreviationSortOf()<CR>", { noremap = true, silent = true })

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
