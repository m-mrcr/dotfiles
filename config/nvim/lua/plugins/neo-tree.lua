return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          -- visible = true means "show filtered/hidden items"
          -- set to false if you want them hidden by default
          visible = true,
          hide_dotfiles = false,     -- show .files
          hide_gitignored = false,   -- show gitignored files
        },
      },
      window = {
        mappings = {
          -- this is an internal Neo-tree mapping, not vim.keymap.set
          ["H"] = "toggle_hidden",   -- press H to toggle hidden files
        },
      },
    })

    -- Global keymap to open Neo-tree from anywhere
    vim.keymap.set(
      "n",
      "<C-n>",
      ":Neotree filesystem reveal left<CR>",
      { silent = true, noremap = true }
    )
  end,
}
