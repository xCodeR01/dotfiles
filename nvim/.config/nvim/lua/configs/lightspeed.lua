local present, lightspeed = pcall(require, "lightspeed")
if not present then
    return
end

-- docs => https://github.com/ggandor/lightspeed.nvim#-configuration
lightspeed.setup({
    jump_to_unique_chars = false,
    safe_labels = {}
})
