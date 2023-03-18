return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
        -- find = "gzf",
        -- find_left = "gzF",
        -- highlight = "gzh",
        -- update_n_lines = "gzn",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")

      ls.config.set_config({
        -- Allow jumping back into snippet, even if you're outside of it
        history = true,
        -- Update as you type in case of dynamic snippets
        updateevents = "TextChanged,TextChangedI",
        -- Autosnippets
        enable_autosnippets = true,
      })

      -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
      require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets" })
    end,
    keys = function()
      return {}
    end,
  },
  -- Disable flit.nvim (~ enhanced f/F/t/T search)
  {
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "jiangmiao/auto-pairs",
  },
  {
    "junegunn/vim-easy-align",
  },
}
