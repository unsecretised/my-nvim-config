require("config.lazy")

require("kanagawa").setup({
	--     transparent = true,
})
vim.cmd("colorscheme kanagawa")

-- vim.cmd("colorscheme gruvbox")

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"

require("config.keymaps")

vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        -- 1 => blinking block
        vim.fn.system("printf '\\e[1 q'")
    end,
})

require("config.lazy")
local function augroup(name)
return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
      if require("lazy.status").has_updates then
	  require("lazy").update({ show = false, })
      end
  end,
})

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

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
-- 	callback = function(args)
-- 		-- 2
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			-- 3
-- 			buffer = args.buf,
-- 			callback = function()
-- 				-- 4 + 5
-- 				vim.lsp.buf.format { async = false, id = args.data.client_id }
-- 			end,
-- 		})
-- 	end
-- })
