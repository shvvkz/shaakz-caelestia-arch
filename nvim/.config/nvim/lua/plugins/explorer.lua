return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
      { "<leader>q", "<cmd>NvimTreeClose<CR>", desc = "Close file explorer" },
      { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Find current file in explorer" },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local function open_nvim_tree(data)
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
          return
        end

        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = open_nvim_tree,
      })

      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,

        sort = {
          sorter = "case_sensitive",
        },

        view = {
          width = 34,
          side = "left",
        },

        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },

        filters = {
          dotfiles = false,
        },

        git = {
          enable = true,
          ignore = false,
        },

        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
    end,
  },
}