return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        map_cr = true,
        enable_check_bracket_line = true,
      })
    end,
  },
}
