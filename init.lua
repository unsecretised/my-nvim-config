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
vim.api.nvim_create_autocmd("VimEnter",{callback=function()require"lazy".update({show = false})end})

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
