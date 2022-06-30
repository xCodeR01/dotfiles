local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- https://github.com/nvim-treesitter/nvim-treesitter#modules
configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "julia",
    "lua",
    "prisma",
    "python",
    "regex",
    "rst",
    "rust",
    "scala",
    "scheme",
    "scss",
    "solidity",
    "toml",
    "tsx",
    "typescript",
    "yaml"
  },
  sync_install = false,
  ignore_install = { "" },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- docs => https://github.com/p00f/nvim-ts-rainbow#installation-and-setup
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 5000,
  }
}
