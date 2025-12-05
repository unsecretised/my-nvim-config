return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
	require("nvim-treesitter.configs").setup {
	  ensure_installed = {
	    "go",
	    "gomod",
	    "lua",
	    "zig",
	    "gleam",
	    "javascript", -- for JSX
	    "typescript", -- if you use TS
	    "tsx",        -- for TSX
	  },
	  highlight = { enable = true },
	}
    end,
  },
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright",
        "rust_analyzer",
        "html",
        "tailwindcss",      -- for Tailwind utility class completions
        "gopls",
        "zls",
        "ts_ls",
      },
      automatic_installation = true,
    })
  end,
},
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        virtual_text = {
          spacing = 2,
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client.server_capabilities.inlayHintProvider then
      return
    end

    -- Disable inlay hints for grammar server(s)
    if client.name == "ltex" or client.name == "ltex_ls" then
      vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
    else
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      local on_attach = function(_, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
        end

        bufmap("n", "gd", vim.lsp.buf.definition)
        bufmap("n", "K", vim.lsp.buf.hover)
      end

      -- Python
 -- Modern Python LSP setup (Neovim 0.11+)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function python_on_attach(client, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
  end

  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "K", vim.lsp.buf.hover)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "<leader>rn", vim.lsp.buf.rename)
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action)

  -- Auto-format on save if supported
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

-- Define the Pyright LSP using the new framework
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  capabilities = capabilities,
  on_attach = python_on_attach,
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
})

-- Optionally add Ruff LSP (for linting/formatting)
if vim.fn.executable("ruff-lsp") == 1 then
  vim.lsp.config("ruff_lsp", {
    cmd = { "ruff-lsp" },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      python_on_attach(client, bufnr)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.completionProvider = false
    end,
  })
end     -- Rust
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            rustfmt = {
              overrideCommand = { "dx", "fmt", "--all-code", "-f", "-" },
            },
            cargo = { allFeatures = true },
            checkOnSave = true,
          },
        },
      })

      -- Go
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      })

      -- Zig
      vim.lsp.config("zls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
}
)
      -- Gleam (manual setup)
local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.gleam then
        configs.gleam = {
          default_config = {
            cmd = { "gleam", "lsp" },
            filetypes = { "gleam" },
            root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
          },
        }
      end

      lspconfig.gleam.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end,
  },

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "html", "css", "javascript", "typescriptreact", "javascriptreact",
    "vue", "svelte", "heex", "eelixir",
  },
})
}
