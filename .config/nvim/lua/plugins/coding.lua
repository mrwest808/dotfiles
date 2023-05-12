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
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-x>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
  {
    "mrwest808/808.nvim",
    config = function()
      require("808").setup()
      vim.keymap.set("i", "<C-e>", "<cmd>ExpandTag<CR>")
    end,
  },
}
