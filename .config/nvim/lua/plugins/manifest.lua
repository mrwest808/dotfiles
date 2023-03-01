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
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      timeout = 3000,
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
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       tsserver = {},
  --       yamlls = {},
  --       cssls = {},
  --       svelte = {},
  --       html = {},
  --     },
  --   },
  -- },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
        -- "shellcheck",
        -- "deno",
        -- "shfmt",
        -- "black",
        -- "isort",
        -- "flake8",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local nls = require("null-ls")
      nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.eslint_d.with({
            -- Only run eslint diagnostics if project has eslint configuration
            condition = function(utils)
              if
                utils.root_has_file({
                  ".eslintrc.js",
                  ".eslintrc.cjs",
                  ".eslintrc.yaml",
                  ".eslintrc.yml",
                  ".eslintrc.json",
                })
              then
                return true
              end

              local Path = require("plenary.path")
              local package_json = Path:new(vim.fn["getcwd"]() .. "/" .. "package.json")

              if package_json:exists() and package_json:is_file() then
                for _, line in ipairs(package_json:readlines()) do
                  if line:match([["eslintConfig"]]) then
                    return true
                  end
                end
              end

              return false
            end,
          }),
          nls.builtins.code_actions.eslint_d,
        },
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
      })
    end,
  },
}
