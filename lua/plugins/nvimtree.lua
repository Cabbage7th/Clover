local options = {
  filters = {
    dotfiles = true,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = false,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
    cursorline = true,
    signcolumn = "yes",
  },
  git = {
    enable = true,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = true,
    highlight_git = true,
    highlight_opened_files = "none",
    highlight_modified = "none",

    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },

    icons = {
        webdev_colors = true,
        git_placement = "after",
        modified_placement = "after",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
        },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "󰉋",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          local function opts(desc)
              return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          api.config.mappings.default_on_attach(bufnr)
          -- your removals and mappings go here
          -- remove a default
          vim.keymap.del('n', '<C-v>', { buffer = bufnr })
          vim.keymap.del('n', '<C-x>', { buffer = bufnr })
          vim.keymap.del('n', '<C-t>', { buffer = bufnr })
          vim.keymap.del('n', '<C-e>', { buffer = bufnr })

          -- add your mappings
          vim.keymap.set('n', 's', api.node.open.vertical,   opts('Open: Vertical Split'))
          vim.keymap.set('n', 'S', api.node.open.horizontal, opts('Open: Horizontal Split'))
          vim.keymap.set('n', 't', api.node.open.tab, opts('Open: Tab'))
      end,
}

return options
