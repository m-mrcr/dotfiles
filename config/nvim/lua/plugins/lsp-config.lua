-- lua/plugins/lsp.lua (for example)
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Let Lazy handle setup via `opts`
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        -- auto-install these if missing
        ensure_installed = { "lua_ls", "ts_ls", "pyright" },
        -- automatic_enable = true, -- default: true, so you can omit this
      },
    },
  },

  config = function()
    -- 1. Keymaps on LspAttach (modern, buffer-local)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        -- Buffer-local LSP keymaps
        local opts = { buffer = ev.buf, noremap = true, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition,       opts)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover,            opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,   opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references,       opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,   opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })

    -- 2. Configure lua_ls with proper settings
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- 3. Configure other servers (basic setup)
    vim.lsp.config("ts_ls", {})
    vim.lsp.config("pyright", {})

    -- 4. Enable all configured servers
    vim.lsp.enable({ "lua_ls", "ts_ls", "pyright" })
  end,
}

