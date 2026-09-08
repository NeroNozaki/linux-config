-- Make sure we're only affecting telescope buffers
if vim.bo.filetype ~= 'telescope' then return end

-- 0. Disable the original hjkl (and related) that telescope sets
local keys_to_nop = {'h', 'j', 'k', 'l','i', '-'}   -- add more if needed, e.g. 'i', '<CR>'
for _, key in ipairs(keys_to_nop) do
  vim.keymap.set('n', key, '<Nop>', { buffer = true, nowait = true })
end

-- 2. Apply your custom motion style inside telescope
--    (telescope mostly uses normal-mode line-wise movement, so 'n' is usually enough)
vim.keymap.set('n', 'i', 'k', {buffer = true, desc = "Up (telescope)"})
vim.keymap.set('n', 'k', 'j', {buffer = true, desc = "Down (telescope)"})
vim.keymap.set('n', 'j', 'h', {buffer = true, desc = "Left/Up dir (telescope)"})
vim.keymap.set('n', 'o', 'l', {buffer = true, desc = "Right/Enter dir (telescope)"})
