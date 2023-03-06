return {
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
    "akinsho/bufferline.nvim",
    -- Overriding <leader>bb in lua/config/keymaps.lua
    keys = {
      { "<leader>bj", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer (jump)" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
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
      window = {
        -- position = "right",
        mappings = {
          ["o"] = "open",
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      timeout = 3000,
    },
  },
}
