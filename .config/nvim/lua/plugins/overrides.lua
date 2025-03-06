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
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Disable keymap colliding with 808.nvim
      opts.keymap["<C-e>"] = {}
      -- Disable navigating snippet jumps with Tab
      opts.keymap["<Tab>"] = { "fallback" }
      opts.keymap["<S-Tab>"] = { "fallback" }

      -- Use <C-k> and <C-j> to navigate snippet jumps
      opts.keymap["<C-k>"] = { "accept", "snippet_forward" }
      opts.keymap["<C-j>"] = { "snippet_backward" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- Unset <C-k> INSERT mode behavior (show signature~)
      keys[#keys + 1] = { "<C-k>", false, mode = "i" }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      agent = "copilot",
      model = "claude-3.5-sonnet",
      prompts = {
        Rephrase = {
          prompt = "Can you improve the clarity and phrasing of this text? Avoid lengthening the text unless necessary for improved clarity. Do your best to keep the intent that the original text is trying to convey.",
          system_prompt = "You are very good with words, you communicate clearly without using overly complicated language. When improving or rephrasing texts, you try your best to keep the original intent of the text, and avoid changing things unnecessarily.",
          description = "Rephrase text.",
        },
      },
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
