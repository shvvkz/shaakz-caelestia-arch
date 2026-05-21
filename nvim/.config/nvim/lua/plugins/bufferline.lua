return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
      })

      vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", {
        desc = "Next buffer",
      })

      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", {
        desc = "Previous buffer",
      })

      vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", {
        desc = "Close current buffer",
      })

      vim.keymap.set("n", "<leader>X", "<cmd>bufdo bdelete<CR>", {
        desc = "Close all buffers",
      })
    end,
  },
}