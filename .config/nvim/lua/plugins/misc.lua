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
      {
        "<C-p>",
        function()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          if vim.v.shell_error == 0 then
            require("telescope.builtin").git_files()
          else
            require("telescope.builtin").find_files({
              find_command = { "rg", "--files", "--hidden", "--glob", "!**/{.git,node_modules}/*" },
            })
          end
        end,
        desc = "Find Files",
      },
    },
  },
}
