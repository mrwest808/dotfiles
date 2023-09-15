if vim.g.vscode then
  -- VS Code
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
