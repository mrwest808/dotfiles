return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      local cwd = vim.fn.getcwd()

      -- Replace home directory with ~ for shorter display
      local home_dir = vim.fn.expand("~")
      if string.sub(cwd, 1, string.len(home_dir)) == home_dir then
        cwd = "~" .. string.sub(cwd, string.len(home_dir) + 1)
      end

      local version_text = "v" .. table.concat({ vim.version().major, vim.version().minor, vim.version().patch }, ".")

      -- The logo ASCII text is 36 characters wide and padded with 2 empty spaces on each side
      local max_string_length = 36
      local version_string_length = string.len(version_text)
      local min_padding = 4

      -- Function to truncate CWD path to fit within display constraints
      local function truncate_cwd_for_display(path, max_length, version_length, min_padding)
        local available_length = max_length - version_length - min_padding

        if string.len(path) <= available_length then
          return path
        end

        -- Split path into segments
        local segments = {}
        for segment in string.gmatch(path, "[^/]+") do
          table.insert(segments, segment)
        end

        -- If no segments (root path), return empty string
        if #segments == 0 then
          return ""
        end

        -- Try to fit as many segments as possible, starting from the end
        local result = segments[#segments] -- Start with just the current directory

        -- If even the current directory is too long, truncate with ellipsis
        if string.len(result) > available_length then
          if available_length >= 6 then -- Minimum: 3 chars + "..."
            result = string.sub(result, 1, available_length - 3) .. "..."
          else
            result = "" -- Still fallback to empty if extremely constrained
          end
        end

        -- Add previous segments if they fit (only if current directory wasn't truncated)
        if not string.find(result, "%.%.%.$") then
          for i = #segments - 1, 1, -1 do
            local potential_result = segments[i] .. "/" .. result
            if string.len(potential_result) <= available_length then
              result = potential_result
            else
              break
            end
          end
        end

        return result
      end

      local display_cwd = truncate_cwd_for_display(cwd, max_string_length, version_string_length, min_padding)
      local cwd_string_length = string.len(display_cwd)
      local padding_length = max_string_length - cwd_string_length - version_string_length

      local logo = {
        -- SAME COLOR LOGO
        -- {
        --   [[
        --     █▀▀▄ █▀▀█ █▀▀█ █▀▀ █▀▀ █▀▀█ █▀▀▄ █▀▀
        --     █░░█ █░░█ █░░█ █▀▀ █░░ █░░█ █░░█ █▀▀
        --     ▀  ▀ ▀▀▀▀ █▀▀▀ ▀▀▀ ▀▀▀ ▀▀▀▀ ▀▀▀  ▀▀▀
        --   ]],
        --   hl = "Info",
        -- },
        -- DIFFERENT COLOR LOGO
        {
          [[
            █▀▀▄ █▀▀█ █▀▀█ █▀▀ ]],
          hl = "Comment",
        },
        {
          [[█▀▀ █▀▀█ █▀▀▄ █▀▀
          ]],
          hl = "Info",
        },
        {
          [[  █░░█ █░░█ █░░█ █▀▀ ]],
          hl = "Comment",
        },
        {
          [[█░░ █░░█ █░░█ █▀▀
          ]],
          hl = "Info",
        },
        {
          [[  ▀  ▀ ▀▀▀▀ █▀▀▀ ▀▀▀ ]],
          hl = "Comment",
        },
        {
          [[▀▀▀ ▀▀▀▀ ▀▀▀  ▀▀▀
          ]],
          hl = "Info",
        },
        {
          "  " .. display_cwd .. string.rep(" ", padding_length) .. version_text .. [[
          ]],
          hl = "Comment",
        },
      }

      opts.dashboard.preset.header = logo
      opts.dashboard.preset.keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      }
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
      -- Only show symbols (signs) for diagnostic issues
      diagnostics = {
        underline = true,
        virtual_text = false,
      },
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
