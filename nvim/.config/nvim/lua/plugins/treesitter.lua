return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ok, treesitter = pcall(require, "nvim-treesitter.configs")

      if not ok then
        return
      end

      treesitter.setup({
        ensure_installed = {
          "rust",
          "lua",
          "toml",
          "json",
          "bash",
          "markdown",
          "markdown_inline",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}