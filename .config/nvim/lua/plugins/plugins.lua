return {
  {
    "mrwest808/808.nvim",
    config = function()
      require("808").setup()
      vim.keymap.set("i", "<C-e>", "<cmd>ExpandTag<CR>")
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
}
