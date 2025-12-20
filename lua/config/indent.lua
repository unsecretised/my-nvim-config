-- Indent / tab settings per filetype

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "rs", "Rust" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gleam", "html", "css", "javascript", "typescript", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})
-- 
-- -- Default for everything else: 4
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "*",
--   callback = function()
--     vim.bo.tabstop = 8
--     vim.bo.shiftwidth = 4
--     vim.bo.softtabstop = 4
--     vim.bo.expandtab = true
--   end,
-- })
