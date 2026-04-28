<h1 align="center">
  <br>
  <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
  <br>
  Clover
  <br>
</h1>

<h4 align="center">A ready-to-use Neovim configuration powered by <a href="https://github.com/folke/lazy.nvim">lazy.nvim</a>, built for efficiency and extensibility.</h4>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue?style=flat-square" alt="Version"/>
  <img src="https://img.shields.io/badge/license-GPL--3.0-green?style=flat-square" alt="License"/>
  <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim"/>
  <img src="https://img.shields.io/badge/Lua-5.1+-000080?style=flat-square&logo=lua&logoColor=white" alt="Lua"/>
</p>

<p align="center">
  English | <strong><a href="README_CN.md">中文</a></strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#screenshots">Screenshots</a> •
  <a href="#prerequisites">Prerequisites</a> •
  <a href="#installation">Installation</a> •
  <a href="#keybindings">Keybindings</a> •
  <a href="#plugin-list">Plugin List</a> •
  <a href="#customization">Customization</a>
</p>

---

## Features

- **Plugin Management** — [lazy.nvim](https://github.com/folke/lazy.nvim) with automatic lazy-loading for fast startup
- **Smart Completion** — [blink.cmp](https://github.com/saghen/blink.cmp) + Codeium AI completion
- **LSP Support** — Mason-managed LSP servers for Lua, Python, C/C++, Web, and more
- **Code Formatting** — none-ls (null-ls) with stylua, prettier, clang-format
- **Fuzzy Search** — Telescope for global search, file finding, and LSP symbol lookup
- **Git Integration** — gitsigns, lazygit, diffview for a complete Git workflow
- **AI Assistant** — CodeCompanion with Kimi, Alibaba Cloud DeepSeek, and Qwen
- **Multi-language** — Treesitter syntax highlighting for C/C++/Python/JS/TS/Lua/Markdown, etc.
- **Rich Themes** — 10+ built-in themes: GitHub Dark, Tokyo Night, Catppuccin, Dracula, Gruvbox, and more
- **Highly Extensible** — Modular design with clean config structure, easy to modify and extend

## Screenshots

<!-- Add screenshots here -->
<!-- ![Main](screenshots/main.png) -->
<!-- ![Completion](screenshots/completion.png) -->
<!-- ![Telescope](screenshots/telescope.png) -->

## Prerequisites

| Tool | Version | Description |
|------|---------|-------------|
| [Neovim](https://neovim.io/) | >= 0.10 | The editor itself |
| [Git](https://git-scm.com/) | >= 2.0 | Plugin downloads |
| [Node.js](https://nodejs.org/) | >= 16.0 | Required by some LSP servers and tools |
| [Nerd Font](https://www.nerdfonts.com/) | Any | For icon display (JetBrainsMono Nerd Font recommended) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Any | Telescope grep search dependency |

**Optional:**

- [lazygit](https://github.com/jesseduffield/lazygit) — Terminal Git UI
- [cscope](http://cscope.sourceforge.net/) — C/C++ code indexing

## Installation

### 1. Back up existing config

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

### 2. Clone the repository

```bash
git clone https://github.com/<your-username>/Clover.git ~/.config/nvim
```

### 3. Launch Neovim

```bash
nvim
```

On first launch, lazy.nvim will automatically download and install all plugins. Treesitter parsers are also installed automatically.

### 4. Install LSP servers and formatters

After plugin installation completes, run inside Neovim:

```vim
:MasonInstallAll
```

This installs all configured LSP servers and formatters (stylua, prettier, clang-format, etc.).

### 5. Set up AI assistant (optional)

To use CodeCompanion AI assistant, set these environment variables:

```bash
# Kimi
export KIMI_API_KEY="your-api-key"
export KIMI_MODE_NAME="moonshot-v1-8k"

# Or Alibaba Cloud DeepSeek
export DASHSCOPE_API_KEY="your-api-key"
```

## Keybindings

> Leader key is `,` (comma)

### General

| Key | Mode | Action |
|-----|------|--------|
| `jk` | Insert | Exit insert mode |
| `Ctrl+s` / `ss` | Normal | Save file |
| `sa` | Normal | Save all files |
| `Ctrl+c` | Normal | Copy entire file |
| `Ctrl+h/j/k/l` | Normal | Window navigation |
| `Shift+j/k` | Normal | Previous/next buffer |
| `Esc` | Normal | Clear search highlight |
| `<leader>n` | Normal | Toggle line numbers |
| `<leader>rn` | Normal | Toggle relative line numbers |

### File Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fa` | Find files (include hidden/ignored) |
| `<leader>fr` | Live grep |
| `<leader>fw` | Grep word under cursor |
| `<leader>fb` | Search buffers |
| `<leader>fh` | Search help tags |
| `<leader>fo` | Recent files |
| `<leader>fz` | Fuzzy find in current buffer |
| `<leader>fs` | LSP document symbols |
| `<leader>fd` | Diagnostics |
| `gr` | LSP references |

### File Tree (NvimTree)

| Key | Action |
|-----|--------|
| `Ctrl+e` | Toggle file tree |
| `s` | Open in vertical split |
| `S` | Open in horizontal split |
| `t` | Open in new tab |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `<leader>H` | Hover documentation |
| `<leader>A` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>fm` | Format code |
| `<leader>D` | Type definition |
| `[e` / `]e` | Previous/next diagnostic |

### Git

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/previous hunk |
| `<leader>ph` | Preview hunk |
| `<leader>rh` | Reset hunk |
| `<leader>gb` | Git blame line |
| `<leader>gd` | Toggle deleted lines |
| `<leader>gt` | Git status (Telescope) |
| `<leader>cm` | Git commits (Telescope) |

### Terminal

| Key | Action |
|-----|--------|
| `Alt+i` | Floating terminal |
| `Alt+h` | Horizontal terminal |
| `Alt+v` | Vertical terminal |
| `Ctrl+x` | Exit terminal mode |

### AI Assistant (CodeCompanion)

| Key | Action |
|-----|--------|
| `Ctrl+a` | AI actions menu |
| `LocalLeader+a` | Toggle AI chat |
| `ga` (Visual) | Add selection to chat |

### Other

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle code outline |
| `<leader><leader>w` | Hop to word |
| `<leader><leader>p` | Hop to pattern |
| `<leader>bp` | Pick buffer |
| `<leader>bc` | Close buffer |
| `<leader>wk` | Query keybindings (WhichKey) |

## Plugin List

<details>
<summary>Click to expand full plugin list</summary>

### Completion & LSP
- [blink.cmp](https://github.com/saghen/blink.cmp) — Auto-completion engine
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — LSP client configuration
- [mason.nvim](https://github.com/williamboman/mason.nvim) — LSP/tool installation manager
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) — Mason-LSP bridge
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) — Formatting/diagnostic injection
- [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) — Function signature help
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) — Lua development enhancements
- [codeium.vim](https://github.com/Exafunction/codeium.vim) / [codeium.nvim](https://github.com/Exafunction/codeium.nvim) — AI code completion
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) — AI programming assistant

### Search & Navigation
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) — Fuzzy search framework
- [hop.nvim](https://github.com/phaazon/hop.nvim) — Fast cursor movement
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) — File explorer
- [outline.nvim](https://github.com/hedyhli/outline.nvim) — Code outline/tagbar
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim) — Refactoring tools
- [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim) — C/C++ code indexing

### Git
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — Line-level git status
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) — Terminal Git UI
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) — Git diff viewer

### UI
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — Status line
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) — Buffer tab bar
- [which-key.nvim](https://github.com/folke/which-key.nvim) — Keybinding hints
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) — File icons
- [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) — Color preview
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) — Indent guides
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) — TODO highlighting
- [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) — Breadcrumb navigation
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) — Rainbow brackets

### Editing
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — Syntax highlighting/parsing
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) — Text objects
- [nvim-surround](https://github.com/kylechui/nvim-surround) — Surround editing
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) — Auto bracket pairing
- [mini.snippets](https://github.com/echasnovski/mini.snippets) — Snippet engine
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) — Snippet collection
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi) — Multi-cursor editing
- [nerdcommenter](https://github.com/scrooloose/nerdcommenter) — Commenting tool
- [targets.vim](https://github.com/wellle/targets.vim) — Extended text objects
- [vim-highlighter](https://github.com/azabiong/vim-highlighter) — Highlight marks
- [better-escape.nvim](https://github.com/max397574/better-escape.nvim) — Better escape
- [tabular](https://github.com/godlygeek/tabular) — Text alignment

### Themes
- [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme) (**default**)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [catppuccin](https://github.com/catppuccin/nvim)
- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim)
- [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
- [nordic.nvim](https://github.com/AlexvZyl/nordic.nvim)
- [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
- [sonokai](https://github.com/sainnhe/sonokai)
- [onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [newpaper.nvim](https://github.com/yorik1984/newpaper.nvim)

### Other
- [nvterm](https://github.com/NvChad/nvterm) — Terminal management
- [project.nvim](https://github.com/ahmedkhalf/project.nvim) — Project management
- [hex.nvim](https://github.com/RaafatTurki/hex.nvim) — Hex editor
- [DoxygenToolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim) — Doxygen comments
- [vista.vim](https://github.com/liuchengxu/vista.vim) — Tag viewer
- [conflict-marker.vim](https://github.com/rhysd/conflict-marker.vim) — Git conflict markers
- [vim-beancount](https://github.com/nathangrigg/vim-beancount) — Beancount syntax
- [markview.nvim](https://github.com/OXY2DEV/markview.nvim) — Markdown preview
- [mini.diff](https://github.com/echasnovski/mini.diff) — Inline diff
- [img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim) — Image paste

</details>

## Customization

### Switch Theme

Edit `lua/config.lua`:

```lua
g.theme = "tokyonight"    -- Options: github_dark, dracula, catppuccin-mocha, gruvbox-material, nordic, etc.
g.background = "dark"     -- dark or light
```

### Add LSP Servers

1. Add the server name to the `ensure_installed` table in `lua/plugins/mason.lua`
2. Add the same name to the `servers` table in `lua/plugins/lspconfig.lua`

```lua
-- lua/plugins/mason.lua
local ensure_installed = {
    -- ... existing servers
    "rust_analyzer",  -- new
}

-- lua/plugins/lspconfig.lua
local servers = { "lua_ls", "bashls", "rust_analyzer" }  -- new
```

### Add Formatters

Add to `null_ls_install_list` in `lua/plugins/mason.lua`, then configure the source in `lua/plugins/none_ls.lua`.

### Local Overrides (not committed to Git)

Create `lua/custom.lua` (already gitignored) for machine-specific settings:

```lua
local M = {}

M.get_beancount = function()
    return '/your/custom/path/main.bean'
end

return M
```

### Toggle Indentation Style

```vim
:IndentToggle
```

## Project Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lazy-lock.json            # Plugin version lock (gitignored)
├── lua/
│   ├── config.lua            # Editor options, globals, leader key
│   ├── mappings.lua          # All keybinding definitions
│   ├── icons.lua             # Icon definitions
│   ├── custom.lua            # Local overrides (gitignored)
│   └── plugins/
│       ├── init.lua          # Plugin list (lazy.nvim entry)
│       ├── lspconfig.lua     # LSP configuration
│       ├── mason.lua         # Mason installation manager
│       ├── none_ls.lua       # Formatting configuration
│       ├── treesitter.lua    # Syntax highlighting config
│       ├── telescope.lua     # Search configuration
│       ├── blink.lua         # Completion configuration
│       ├── lualine.lua       # Status line config
│       ├── bufferline.lua    # Buffer tab bar config
│       ├── nvimtree.lua      # File tree config
│       ├── gitsigns.lua      # Git status config
│       ├── codecompanion.lua # AI assistant config
│       └── ...               # Other plugin configs
```

## Custom Commands

| Command | Description |
|---------|-------------|
| `:IndentToggle` | Toggle Tab/Space indentation |
| `:MasonInstallAll` | Install all formatters |
| `:NvimTreeToggle` | Toggle file tree |
| `:Telescope` | Open Telescope search |
| `:Lazy` | Open plugin manager |
| `:LazyGit` | Open LazyGit |
| `:DiffviewOpen` | Open diff viewer |
| `:Outline` | Open code outline |

## License

[GPL-3.0](LICENSE)
