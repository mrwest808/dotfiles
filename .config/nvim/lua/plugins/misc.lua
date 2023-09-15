local Util = require("lazyvim.util")

local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local function get_find_files_opts()
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  return opts
end

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- {
      --   "<C-p>",
      --   function()
      --     vim.fn.system("git rev-parse --is-inside-work-tree")
      --     if vim.v.shell_error == 0 then
      --       require("telescope.builtin").git_files()
      --     else
      --       require("telescope.builtin").find_files({
      --         find_command = { "rg", "--files", "--hidden", "--glob", "!**/{.git,node_modules}/*" },
      --       })
      --     end
      --   end,
      --   desc = "Find Files",
      -- },
      {
        "<C-p>",
        Util.telescope("files", get_find_files_opts()),
        desc = "Find Files",
      },
    },
  },
}
