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
  -- Disable flit.nvim (~ enhanced f/F/t/T search)
  {
    "ggandor/flit.nvim",
    enabled = false,
  },
}
