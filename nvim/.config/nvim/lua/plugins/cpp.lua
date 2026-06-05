return {
  {
    "cpp-lsp-config",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--fallback-style=llvm",
        },
        root_markers = {
          "compile_commands.json",
          "compile_flags.txt",
          ".clangd",
          "Makefile",
          ".git",
        },
      })

      vim.lsp.enable("clangd")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "c",
          "cpp",
          "objc",
          "objcpp",
        },
        callback = function()
          vim.opt_local.expandtab = true
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.softtabstop = 4

          vim.opt_local.autoindent = true
          vim.opt_local.smartindent = false
          vim.opt_local.cindent = true
          vim.opt_local.indentexpr = ""

          vim.opt_local.cinkeys = "0{,0},0),:,0#,!^F,o,O,e"
          vim.opt_local.cinoptions = ":0,l1,t0,g0,(0,u0,w1,W4"
        end,
      })
    end,
  },
}
