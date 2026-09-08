-- Make sure we're only affecting netrw buffers
if vim.bo.filetype ~= 'netrw' then return end

-- 1. Disable the original hjkl (and related) that netrw sets
local keys_to_nop = {'h', 'j', 'k', 'l','i', '-'}   -- add more if needed, e.g. 'i', '<CR>'
for _, key in ipairs(keys_to_nop) do
  vim.keymap.set('n', key, '<Nop>', { buffer = true, nowait = true })
end

-- 2. Apply your custom motion style inside netrw
--    (netrw mostly uses normal-mode line-wise movement, so 'n' is usually enough)
vim.keymap.set('n', 'i', 'k', {buffer = true, desc = "Up (netrw)"})
vim.keymap.set('n', 'k', 'j', {buffer = true, desc = "Down (netrw)"})
vim.keymap.set('n', 'j', 'h', {buffer = true, desc = "Left/Up dir (netrw)"})
vim.keymap.set('n', 'o', 'l', {buffer = true, desc = "Right/Enter dir (netrw)"})
