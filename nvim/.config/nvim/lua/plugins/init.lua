-- ========== Flash Helpers ==========
local function flash_two_stage_word_jump(pattern)
  local function pick_label(opts)
    local state = require("flash.state").new(opts)
    vim.cmd.redraw()
    local char = state:get_char()
    state:hide()
    if char and state:find({ label = char }) then
      state:jump(char)
    else
      state:restore()
      -- Consume invalid input and cancel any pending operator too.
      vim.api.nvim_input("<Esc>")
    end
  end

  local function format(opts)
    return {
      { opts.match.label1 or "", "FlashMatch" },
      { opts.match.label2 or opts.match.label or "", "FlashLabel" },
    }
  end

  pick_label({
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
      pick_label({
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
  -- ========== Dracula ==========
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },
  -- ========== Mini Comment ==========
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
  -- ========== Flash ==========
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
  -- ========== Telescope ==========
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      {
        "<leader>fa",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find all files",
      },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    opts = function()
      local actions = require("telescope.actions")

      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        group = vim.api.nvim_create_augroup("TelescopePreviewNumbers", { clear = true }),
        callback = function()
          vim.wo.number = true
          vim.wo.relativenumber = false
        end,
      })

      return {
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = "top",
            flex = {
              flip_columns = 120,
              flip_lines = 1,
            },
            horizontal = {
              preview_width = 0.6,
              preview_cutoff = 0,
            },
            vertical = {
              preview_height = 0.55,
              preview_cutoff = 0,
            },
          },
          file_ignore_patterns = {
            "^%.git/",
          },
          mappings = {
            i = {
              ["<Esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["<Esc>"] = actions.close,
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
    "mikavilpas/yazi.nvim",
    version = "*",
    cmd = "Yazi",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<C-e>", "<cmd>Yazi cwd<cr>", desc = "Browse working directory with Yazi" },
    },
    opts = {},
  },
  -- ========== Twilight ==========
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
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
      highlights = {
        line_insert = "#28382e",
        char_insert = "#35543e",
      },
    },
    keys = {
      { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Review Git changes" },
    },
  },
  -- ========== Lualine ==========
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
