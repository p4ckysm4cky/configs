return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>eb",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            pattern = [[\<\k]],
            search = {
              mode = "search",
              multi_window = false,
            },
            label = {
              after = { 0, 0 },
              before = false,
            },
            highlight = {
              backdrop = true,
              matches = false,
            },
          })
        end,
        desc = "Flash word begin",
      },
      {
        "<leader>ee",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            pattern = [[\k\>]],
            search = {
              mode = "search",
              multi_window = false,
            },
            label = {
              after = { 0, 0 },
              before = false,
            },
            highlight = {
              backdrop = true,
              matches = false,
            },
          })
        end,
        desc = "Flash word end",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    opts = {},
  },
}
