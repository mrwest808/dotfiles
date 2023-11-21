return {
  {
    "github/copilot.vim",
    lazy = true,
    cmd = "LazyInitCopilot",
    config = function()
      vim.api.nvim_create_user_command("LazyInitCopilot", function()
        vim.cmd("CopilotLazyEnable")
      end, {})

      vim.api.nvim_create_user_command("CopilotLazyEnable", function()
        vim.cmd("Copilot enable")
        vim.cmd("Copilot status")
      end, {})

      vim.api.nvim_create_user_command("CopilotLazyDisable", function()
        vim.cmd("Copilot disable")
        vim.cmd("Copilot status")
      end, {})

      vim.api.nvim_create_user_command("CopilotLazyStatus", function()
        vim.cmd("Copilot status")
      end, {})
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    event = "VeryLazy",
    keys = {
      {
        "<leader>cp",
        function()
          -- Show only 'Copilot INIT' before the plugin is loaded
          local function get_copilot_commands()
            if vim.fn.exists(":Copilot") == 0 then
              return {
                { display = "Copilot INIT", cmd = "LazyInitCopilot" },
              }
            else
              return {
                { display = "Copilot ON", cmd = "CopilotLazyEnable" },
                { display = "Copilot OFF", cmd = "CopilotLazyDisable" },
                { display = "Copilot status", cmd = "CopilotLazyStatus" },
              }
            end
          end

          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")
          local finders = require("telescope.finders")
          local make_entry = require("telescope.make_entry")
          local pickers = require("telescope.pickers")
          local opts = {}

          local commands = get_copilot_commands()

          pickers
            .new(opts, {
              prompt_title = "Copilot",
              finder = finders.new_table({
                results = commands,
                entry_maker = function(line)
                  return make_entry.set_default_entry_mt({
                    ordinal = line.display,
                    display = line.display,
                    run_cmd = line.cmd,
                  }, opts)
                end,
              }),
              attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                  local selection = action_state.get_selected_entry()

                  if selection == nil then
                    return
                  end

                  if selection.run_cmd ~= "LazyInitCopilot" then
                    if vim.fn.exists(":Copilot") == 0 then
                      print("Not executable, run 'Copilot ON' first.")
                      return
                    end
                  end

                  actions.close(prompt_bufnr)
                  vim.cmd(selection.run_cmd)
                end)

                return true
              end,
            })
            :find()
        end,
        desc = "Enable Copilot",
      },
    },
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   suggestion = {
  --     enabled = true,
  --   },
  --   panel = {
  --     enabled = true,
  --     auto_refresh = true,
  --   },
  -- },
}
