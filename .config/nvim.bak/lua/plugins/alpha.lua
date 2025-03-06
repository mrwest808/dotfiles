return {
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      --     local logo = [[
      -- ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
      -- ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
      -- ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
      -- ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
      -- ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
      -- ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      -- ]]
      local cwd = vim.fn.getcwd()
      local spaces = string.rep(" ", math.ceil(#cwd / 2 - 5))
      local logo = [[


   ]] .. spaces .. [[༼ つ ◕_◕ ༽つ
      
   ]] .. cwd .. [[

  ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
  },
  -- {
  --   "glepnir/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = function()
  --     -- local dashboard = require("alpha.themes.dashboard")
  --     --     local logo = [[
  --     -- ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
  --     -- ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
  --     -- ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
  --     -- ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
  --     -- ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
  --     -- ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
  --     -- ]]
  --     local cwd = vim.fn.getcwd()
  --     local spaces = string.rep(" ", math.ceil(#cwd / 2 - 5))
  --     local logo = [[
  --
  --
  --  ]] .. spaces .. [[༼ つ ◕_◕ ༽つ
  --
  --  ]] .. cwd .. [[
  --
  -- ]]
  --
  --     local opts = {
  --       theme = "doom",
  --       hide = {
  --         -- this is taken care of by lualine
  --         -- enabling this messes up the actual laststatus setting after loading a file
  --         statusline = false,
  --       },
  --       config = {
  --         header = vim.split(logo, "\n"),
  --         -- stylua: ignore
  --         center = {
  --           { action = "Telescope find_files",              desc = " Find file",       icon = " ", key = "f" },
  --           { action = "ene | startinsert",                 desc = " New file",        icon = " ", key = "n" },
  --           { action = "Telescope oldfiles",                desc = " Recent files",    icon = " ", key = "r" },
  --           { action = "Telescope live_grep",               desc = " Find text",       icon = " ", key = "g" },
  --           { action = "e $MYVIMRC",                        desc = " Config",          icon = " ", key = "c" },
  --           { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
  --           { action = "LazyExtras",                        desc = " Lazy Extras",     icon = " ", key = "e" },
  --           { action = "Lazy",                              desc = " Lazy",            icon = "󰒲 ", key = "l" },
  --           { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
  --         },
  --         footer = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --         end,
  --       },
  --     }
  --
  --     for _, button in ipairs(opts.config.center) do
  --       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --     end
  --
  --     -- close Lazy and re-open when the dashboard is ready
  --     if vim.o.filetype == "lazy" then
  --       vim.cmd.close()
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "DashboardLoaded",
  --         callback = function()
  --           require("lazy").show()
  --         end,
  --       })
  --     end
  --
  --     return opts
  --
  --     -- dashboard.section.header.val = vim.split(logo, "\n")
  --     -- dashboard.section.buttons.val = {
  --     --   dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  --     --   dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  --     --   dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  --     --   dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
  --     --   dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
  --     --   dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
  --     --   dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
  --     --   dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  --     -- }
  --     -- for _, button in ipairs(dashboard.section.buttons.val) do
  --     --   button.opts.hl = "AlphaButtons"
  --     --   button.opts.hl_shortcut = "AlphaShortcut"
  --     -- end
  --     -- dashboard.section.footer.opts.hl = "Type"
  --     -- dashboard.section.header.opts.hl = "AlphaHeader"
  --     -- dashboard.section.buttons.opts.hl = "AlphaButtons"
  --     -- dashboard.opts.layout[1].val = 8
  --     -- return dashboard
  --   end,
  -- },
}
