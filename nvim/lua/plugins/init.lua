return {
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
}
