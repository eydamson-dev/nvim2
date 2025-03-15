return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = false,
        ensure_installed = { 'bashls', 'cssmodules_ls', 'eslint', 'html', 'jsonls', 'lua_ls', }
      })

      local cmp_capabilities = require('cmp_nvim_lsp')
      local capabilities = cmp_capabilities.default_capabilities()
      local lspconfig = require('lspconfig')

      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
      end

      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {}
        end,

        vtsls = function()
          lspconfig.vtsls.setup({
            capabilities = capabilities,
            commands = {
              OrganizeImports = {
                organize_imports,
                description = "Organize Imports"
              }
            },
            on_attach = function(client, bufnr)
              -- Wrap the LSP format function to also organize imports
              local orig_format = vim.lsp.buf.format
              vim.lsp.buf.format = function(opts)
                organize_imports() -- Run organize imports before formatting
                orig_format(opts)  -- Call the original format function
              end
            end,
          })
        end
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

          -- Lspsaga
          vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)
          vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)

          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      local wk = require('which-key')
      wk.add({
        { "<leader>l",  group = "LSP" },
        { "<leader>la", "<cmd>Lspsaga code_action<cr>",                     desc = "Code Actions" },
        { "<leader>ld", "<cmd>Lspsaga show_cursor_diagnostics<cr>",         desc = "Cursor Diagnostic" },
        { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>",     desc = "Workspace Diagnostics" },
        { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>",  desc = "Format" },
        { "<leader>lh", "<cmd>Lspsaga hover_doc<cr>",                       desc = "Hover" },
        { "<leader>li", "<cmd>LspInfo<cr>",                                 desc = "Info" },
        { "<leader>lI", "<cmd>LspInstallInfo<cr>",                          desc = "Installer Info" },
        { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",      desc = "Next Diagnostic" },
        { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",      desc = "Prev Diagnostic" },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",              desc = "CodeLens Action" },
        { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",    desc = "Quickfix" },
        { "<leader>lr", "<cmd>Lspsaga rename<cr>",                          desc = "Rename" },
        { "<leader>lR", "<cmd>Telescope lsp_references<cr>",                desc = "References" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Document Symbols" },
        { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
      })
    end
  }
}
