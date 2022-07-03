local present, colorizer = pcall(require, "colorizer")
if not present then
  return
end

-- docs => https://github.com/norcalli/nvim-colorizer.lua#customization
colorizer.setup({
  'css',
  html = {
    mode = 'foreground',
  },
  'javascript',
  'typescript',
}, {
  RGB      = true,
  RRGGBB   = true,
  names    = true,
  css_fn   = true,
  mode     = 'background',
})
