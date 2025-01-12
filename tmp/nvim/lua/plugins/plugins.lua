return {
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
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      agent = "copilot",
      model = "claude-3.5-sonnet",
      prompts = {},
      question_header = "  JW ",
      mappings = {
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-Enter>",
        },
        accept_diff = {
          normal = nil,
          insert = nil,
        },
      },
    },
  },
}
