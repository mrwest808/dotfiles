return {
  {
    "mrwest808/808.nvim",
    config = function()
      require("808").setup()
      vim.keymap.set("i", "<C-e>", function()
        -- Emmet-like tag expansion
        require("808.commands").expand_tag()
        -- Make sure to close autocomplete menu
        require("blink.cmp").hide()
      end)
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
      keymaps = {
        ["<BS>"] = "actions.parent",
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "-", "<Cmd>Oil<CR>", desc = "Open parent directory" },
    },
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "derektata/lorem.nvim",
    config = function()
      require("lorem").opts({
        sentence_length = "medium",
        comma_chance = 0.2,
        max_commas = 2,
      })
    end,
  },
}
