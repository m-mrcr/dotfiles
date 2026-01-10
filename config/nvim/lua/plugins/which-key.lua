return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    win = {
      border = "single",
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local wk = require("which-key")
    wk.setup(opts)

    -- Add key groups and mappings
    wk.add({
      -- Find operations (Telescope)
      { "<leader>f", group = "find" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find Commands" },

      -- Git operations
      { "<leader>g", group = "git" },

      -- Toggle/UI
      { "<leader>t", group = "toggle" },
      { "<C-n>", "<cmd>Neotree filesystem reveal left<cr>", desc = "Toggle File Tree" },
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

      -- LSP operations
      { "<leader>l", group = "lsp" },
      { "<leader>rn", desc = "Rename Symbol" },
      { "<leader>ca", desc = "Code Action" },

      -- LSP go-to commands
      { "g", group = "goto" },
      { "gd", desc = "Go to Definition" },
      { "gi", desc = "Go to Implementation" },
      { "gr", desc = "Go to References" },
      { "K", desc = "Hover Documentation" },
    })
  end,
}
