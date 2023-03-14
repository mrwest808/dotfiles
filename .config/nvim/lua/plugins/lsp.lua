return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       denols = {
  --         root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
  --       },
  --       tsserver = {
  --         root_dir = require("lspconfig").util.root_pattern("package.json"),
  --         single_file_support = false,
  --       },
  --     },
  --   },
  -- },
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
