-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local LazyVim = require("lazyvim.util")
local map = vim.keymap

-- Up/down navigation
map.set("n", "<C-d>", "5<C-e>")
map.set("n", "<C-u>", "5<C-y>")

-- Increment / decrement numbers
map.set("n", "<leader>ni", "<C-a>")
map.set("n", "<leader>nd", "<C-x>")

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

-- -> Open file finder
local is_inside_work_tree = {}
local work_tree_root = {}

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local function get_files_cwd()
  local cwd = vim.fn.getcwd()

  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")

    is_inside_work_tree[cwd] = vim.v.shell_error == 0

    if is_inside_work_tree[cwd] then
      work_tree_root[cwd] = get_git_root()
    end
  end

  if is_inside_work_tree[cwd] then
    return work_tree_root[cwd]
  end
end

map.set("n", "<C-p>", LazyVim.pick("files", { cwd = get_files_cwd(), show_untracked = true }))
