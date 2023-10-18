return {
  {
    "github/copilot.vim",
    lazy = true,
    cmd = "LazyInitCopilot",
    -- init = function()
    --   vim.cmd([[command LazyInitCopilot echo "This is a custom command"]])
    -- end,
    -- keys = {
    --   {
    --     "<C-p>",
    --     mode = { "i" },
    --     function()
    --       print("Hello")
    --       print("There")
    --     end,
    --     desc = "Wat",
    --   },
    -- },
  },
  -- TODO: Modify available commands based on whether or not module is loaded
  -- TODO: Before loaded, only show "Initialize Copilot"
  -- TODO: After loaded, show "Enable Copilot", "Disable Copilot", and "Copilot status"
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    event = "VeryLazy",
    keys = {
      {
        "<leader>cp",
        function()
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")
          local finders = require("telescope.finders")
          local make_entry = require("telescope.make_entry")
          local pickers = require("telescope.pickers")
          local opts = {}
          local commands = {
            { display = "Copilot ON", cmd = "LazyInitCopilot" },
            { display = "Copilot OFF", cmd = "Copilot disable" },
            { display = "Copilot status", cmd = "Copilot status" },
          }

          if vim.fn.exists("g:plugs['github/copilot.vim']") then
            print("Copilot")
            print("Enabled")
          else
            print("Copilot")
            print("Disabled")
          end

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
-- {
--   "<C-p>",
--   Util.telescope("files", get_find_files_opts()),
--   desc = "Find Files",
-- },
