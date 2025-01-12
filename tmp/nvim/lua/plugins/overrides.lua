return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      local cwd = vim.fn.getcwd()
      local logo = [[


  ༼ つ ◕_◕ ༽つ

]] .. cwd .. [[

]]

      opts.dashboard.preset.header = logo
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "dark",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bj", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer (jump)" },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  -- {
  --   "saghen/blink.cmp",
  --   sources = {
  --     default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
  --   },
  -- },
}
