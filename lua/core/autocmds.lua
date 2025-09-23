local aug = vim.api.nvim_create_augroup
local au  = vim.api.nvim_create_autocmd

-- Trim trailing whitespace on save (non-destructive cursor)
local trim = aug("TrimTrailing", { clear = true })
au("BufWritePre", {
  group = trim,
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

