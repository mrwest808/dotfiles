local Util = require("lazyvim.util")

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

return {
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "prettierd",
  --       "stylua",
  --       "eslint_d",
  --     },
  --   },
  -- },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<C-p>",
        Util.pick("auto", {
          cwd = get_files_cwd(),
          show_untracked = true,
        }),
        desc = "Find Files",
      },
    },
  },
  {
    "CrispyDrone/vim-tasks",
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      mac_window_bar = false,
      code_font_family = "SFMono Nerd Font",
      watermark = "",
      min_width = 860,
    },
  },
}
