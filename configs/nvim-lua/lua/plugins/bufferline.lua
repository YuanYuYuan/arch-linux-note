require'bufferline'.setup{
  options = {
    diagnostics = "nvim_lsp",
    mappings = true,
    -- separator_style = "slant"
  }
}

vim.api.nvim_set_keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "L", ":BufferLineMoveNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "H", ":BufferLineMovePrev<CR>", {silent = true})
