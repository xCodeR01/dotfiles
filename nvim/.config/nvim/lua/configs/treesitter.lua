local present, configs = pcall(require, "nvim-treesitter.configs")
if not present then
  return
end

-- https://github.com/nvim-treesitter/nvim-treesitter#modules
configs.setup {
  ensure_installed = {
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
    "yaml",
  },
  sync_install = false,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  -- for JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- for windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- for p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 5000,
  },
}
