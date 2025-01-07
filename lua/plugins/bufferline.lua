return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        themable = true,
        show_buffer_close_icons = false,
        show_tab_indicators = false,
        separator_style = "slant",
        indicator = {
          style = "none",
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "FileExplorer",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
  },
}
