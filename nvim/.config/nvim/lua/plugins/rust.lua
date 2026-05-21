return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          cmd = function()
            local rustup_ra = vim.fn.expand("~/.cargo/bin/rust-analyzer")
            local mason_ra = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"

            if vim.fn.executable(rustup_ra) == 1 then
              return { rustup_ra }
            end

            if vim.fn.executable(mason_ra) == 1 then
              return { mason_ra }
            end

            return { "rust-analyzer" }
          end,

          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },

              check = {
                command = "clippy",
              },

              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },

          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr }

            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end

            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp("runnables")
            end, opts)

            vim.keymap.set("n", "<leader>rd", function()
              vim.cmd.RustLsp("debuggables")
            end, opts)

            vim.keymap.set("n", "<leader>re", function()
              vim.cmd.RustLsp("explainError")
            end, opts)

            vim.keymap.set("n", "<leader>rm", function()
              vim.cmd.RustLsp("expandMacro")
            end, opts)

            vim.keymap.set("n", "<leader>rh", function()
              vim.cmd.RustLsp("hover", "actions")
            end, opts)

            vim.keymap.set("n", "<leader>ti", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
            end, opts)
          end,
        },
      }
    end,
  },

  {
    "mfussenegger/nvim-dap",
  },
}