local function flash_two_stage_word_jump(pattern)
  local flash = require("flash")

  local function format(opts)
    return {
      { opts.match.label1 or "", "FlashMatch" },
      { opts.match.label2 or opts.match.label or "", "FlashLabel" },
    }
  end

  flash.jump({
    pattern = pattern,
    search = {
      mode = "search",
      multi_window = false,
      max_length = 0,
    },
    label = {
      after = false,
      before = { 0, 0 },
      format = format,
    },
    highlight = {
      backdrop = true,
      matches = false,
    },
    action = function(match, state)
      state:hide()
      flash.jump({
        search = {
          max_length = 0,
        },
        label = {
          after = false,
          before = { 0, 0 },
          format = format,
        },
        highlight = {
          backdrop = true,
          matches = false,
        },
        matcher = function(win)
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.label2
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()

      for i, match in ipairs(matches) do
        match.label1 = labels[math.floor((i - 1) / #labels) + 1]
        match.label2 = labels[(i - 1) % #labels + 1]
        match.label = match.label1
      end
    end,
  })
end

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
    "nvim-mini/mini.comment",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup()

      vim.keymap.set("n", "<C-_>", function()
        return MiniComment.operator() .. "_"
      end, { expr = true, desc = "Toggle comment line" })

      vim.keymap.set("x", "<C-_>", function()
        return MiniComment.operator()
      end, { expr = true, desc = "Toggle comment selection" })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      label = {
        uppercase = false,
        distance = true,
      },
    },
    keys = {
      {
        "<leader>eb",
        mode = { "n", "x", "o" },
        function()
          flash_two_stage_word_jump([[\<\k]])
        end,
        desc = "Flash word begin",
      },
      {
        "<leader>ee",
        mode = { "n", "x", "o" },
        function()
          flash_two_stage_word_jump([[\k\>]])
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
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          file_ignore_patterns = {
            "^%.git/",
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      }
    end,
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    keys = {
      { "<leader>vt", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {
      treesitter = false,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
