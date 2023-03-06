return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
        "deno",
        -- "shellcheck",
        -- "shfmt",
        -- "black",
        -- "isort",
        -- "flake8",
      },
    },
  },
}
