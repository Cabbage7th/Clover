<h1 align="center">
  <br>
  <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
  <br>
  Clover
  <br>
</h1>

<h4 align="center">一套开箱即用的 Neovim 配置方案，基于 <a href="https://github.com/folke/lazy.nvim">lazy.nvim</a> 插件管理器，追求高效与可定制性。</h4>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue?style=flat-square" alt="Version"/>
  <img src="https://img.shields.io/badge/license-GPL--3.0-green?style=flat-square" alt="License"/>
  <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim"/>
  <img src="https://img.shields.io/badge/Lua-5.1+-000080?style=flat-square&logo=lua&logoColor=white" alt="Lua"/>
</p>

<p align="center">
  <strong><a href="README.md">English</a></strong> | 中文
</p>

<p align="center">
  <a href="#特性">特性</a> •
  <a href="#截图">截图</a> •
  <a href="#前置要求">前置要求</a> •
  <a href="#安装">安装</a> •
  <a href="#快捷键">快捷键</a> •
  <a href="#插件列表">插件列表</a> •
  <a href="#自定义">自定义</a>
</p>

---

## 特性

- **插件管理** — 基于 [lazy.nvim](https://github.com/folke/lazy.nvim)，自动懒加载，启动速度快
- **智能补全** — [blink.cmp](https://github.com/saghen/blink.cmp) + Codeium AI 补全
- **LSP 支持** — 通过 Mason 自动安装管理 LSP 服务器，支持 Lua、Python、C/C++、Web 等
- **代码格式化** — none-ls (null-ls) 集成 stylua、prettier、clang-format
- **模糊搜索** — Telescope 全局搜索、文件查找、LSP 符号搜索
- **Git 集成** — gitsigns、lazygit、diffview 一站式 Git 工作流
- **AI 编程助手** — CodeCompanion 集成 Kimi、阿里云 DeepSeek、通义千问
- **多语言支持** — Treesitter 语法高亮，覆盖 C/C++/Python/JS/TS/Lua/Markdown 等
- **丰富的主题** — 内置 10+ 主题：GitHub Dark、Tokyo Night、Catppuccin、Dracula、Gruvbox 等
- **可定制性** — 模块化设计，配置文件结构清晰，易于修改扩展

## 截图

<!-- 在此处添加截图 -->
<!-- ![主界面](screenshots/main.png) -->
<!-- ![补全](screenshots/completion.png) -->
<!-- ![Telescope](screenshots/telescope.png) -->

## 前置要求

| 工具 | 版本要求 | 说明 |
|------|---------|------|
| [Neovim](https://neovim.io/) | >= 0.10 | 编辑器本体 |
| [Git](https://git-scm.com/) | >= 2.0 | 插件下载 |
| [Node.js](https://nodejs.org/) | >= 16.0 | 部分 LSP 和工具依赖 |
| [Nerd Font](https://www.nerdfonts.com/) | 任意 | 图标显示（推荐 JetBrainsMono Nerd Font） |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | 任意 | Telescope grep 搜索依赖 |

**可选依赖：**

- [lazygit](https://github.com/jesseduffield/lazygit) — 终端 Git UI
- [cscope](http://cscope.sourceforge.net/) — C/C++ 代码索引

## 安装

### 1. 备份已有配置

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

### 2. 克隆仓库

```bash
git clone https://github.com/Cabbage7th/Clover.git ~/.config/nvim
```

### 3. 启动 Neovim

```bash
nvim
```

首次启动时，lazy.nvim 会自动下载并安装所有插件。Treesitter 语法解析器也会自动安装。

### 4. 安装 LSP 和格式化工具

插件安装完成后，在 Neovim 中运行：

```vim
:MasonInstallAll
```

这会自动安装配置中列出的所有 LSP 服务器和格式化工具（stylua、prettier、clang-format 等）。

### 5. 配置 AI 助手（可选）

如需使用 CodeCompanion AI 助手，设置以下环境变量：

```bash
# Kimi
export KIMI_API_KEY="your-api-key"
export KIMI_MODE_NAME="moonshot-v1-8k"

# 或阿里云 DeepSeek
export DASHSCOPE_API_KEY="your-api-key"
```

## 快捷键

> Leader 键为 `,`（逗号）

### 通用

| 按键 | 模式 | 功能 |
|------|------|------|
| `jk` | 插入 | 退出插入模式 |
| `Ctrl+s` / `ss` | 普通 | 保存文件 |
| `sa` | 普通 | 保存所有文件 |
| `Ctrl+c` | 普通 | 复制整个文件 |
| `Ctrl+h/j/k/l` | 普通 | 窗口间跳转 |
| `Shift+j/k` | 普通 | 切换上/下一个 Buffer |
| `Esc` | 普通 | 取消搜索高亮 |
| `<leader>n` | 普通 | 切换行号 |
| `<leader>rn` | 普通 | 切换相对行号 |

### 文件搜索 (Telescope)

| 按键 | 功能 |
|------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fa` | 查找文件（含隐藏/忽略） |
| `<leader>fr` | 全局搜索 (grep) |
| `<leader>fw` | 搜索光标下单词 |
| `<leader>fb` | 搜索 Buffer |
| `<leader>fh` | 搜索帮助文档 |
| `<leader>fo` | 最近打开的文件 |
| `<leader>fz` | 当前文件模糊搜索 |
| `<leader>fs` | LSP 文档符号 |
| `<leader>fd` | 诊断信息 |
| `gr` | LSP 引用搜索 |

### 文件树 (NvimTree)

| 按键 | 功能 |
|------|------|
| `Ctrl+e` | 切换文件树 |
| `s` | 垂直分屏打开 |
| `S` | 水平分屏打开 |
| `t` | 新标签页打开 |

### LSP

| 按键 | 功能 |
|------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gi` | 跳转到实现 |
| `gr` | 查找引用 |
| `<leader>H` | 悬停文档 |
| `<leader>A` | 代码动作 |
| `<leader>rn` | 重命名符号 |
| `<leader>fm` | 格式化代码 |
| `<leader>D` | 类型定义 |
| `[e` / `]e` | 上/下一个诊断 |

### Git

| 按键 | 功能 |
|------|------|
| `]c` / `[c` | 下/上一个 Hunk |
| `<leader>ph` | 预览 Hunk |
| `<leader>rh` | 重置 Hunk |
| `<leader>gb` | 行级 Git Blame |
| `<leader>gd` | 显示/隐藏删除行 |
| `<leader>gt` | Git 状态 (Telescope) |
| `<leader>cm` | Git 提交记录 (Telescope) |

### 终端

| 按键 | 功能 |
|------|------|
| `Alt+i` | 浮动终端 |
| `Alt+h` | 水平终端 |
| `Alt+v` | 垂直终端 |
| `Ctrl+x` | 退出终端模式 |

### AI 助手 (CodeCompanion)

| 按键 | 功能 |
|------|------|
| `Ctrl+a` | AI 动作菜单 |
| `LocalLeader+a` | 切换 AI 聊天 |
| `ga` (可视) | 添加选中内容到聊天 |

### 其他

| 按键 | 功能 |
|------|------|
| `<leader>tt` | 切换代码大纲 |
| `<leader><leader>w` | Hop 单词跳转 |
| `<leader><leader>p` | Hop 模式跳转 |
| `<leader>bp` | 选择 Buffer |
| `<leader>bc` | 关闭 Buffer |
| `<leader>wk` | 查询快捷键 (WhichKey) |

## 插件列表

<details>
<summary>点击展开完整插件列表</summary>

### 补全与 LSP
- [blink.cmp](https://github.com/saghen/blink.cmp) — 自动补全引擎
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — LSP 客户端配置
- [mason.nvim](https://github.com/williamboman/mason.nvim) — LSP/工具安装管理
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) — Mason 与 LSP 桥接
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) — 格式化/诊断注入
- [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) — 函数签名提示
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) — Lua 开发增强
- [codeium.vim](https://github.com/Exafunction/codeium.vim) / [codeium.nvim](https://github.com/Exafunction/codeium.nvim) — AI 代码补全
- [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) — AI 编程助手

### 搜索与导航
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) — 模糊搜索框架
- [hop.nvim](https://github.com/phaazon/hop.nvim) — 快速跳转
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) — 文件资源管理器
- [outline.nvim](https://github.com/hedyhli/outline.nvim) — 代码大纲/标签栏
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim) — 重构工具
- [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim) — C/C++ 代码索引

### Git
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — 行级 Git 状态
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) — 终端 Git UI
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) — Git Diff 视图

### UI
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — 状态栏
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) — Buffer 标签栏
- [which-key.nvim](https://github.com/folke/which-key.nvim) — 快捷键提示
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) — 文件图标
- [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) — 颜色预览
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) — 缩进线
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) — TODO 高亮
- [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) — 面包屑导航
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) — 彩色括号

### 编辑增强
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — 语法高亮/解析
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) — 文本对象
- [nvim-surround](https://github.com/kylechui/nvim-surround) — 包围编辑
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) — 自动括号配对
- [mini.snippets](https://github.com/echasnovski/mini.snippets) — 代码片段引擎
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) — 代码片段集合
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi) — 多光标编辑
- [nerdcommenter](https://github.com/scrooloose/nerdcommenter) — 注释工具
- [targets.vim](https://github.com/wellle/targets.vim) — 扩展文本对象
- [vim-highlighter](https://github.com/azabiong/vim-highlighter) — 高亮标记
- [better-escape.nvim](https://github.com/max397574/better-escape.nvim) — 更好的 Esc
- [tabular](https://github.com/godlygeek/tabular) — 文本对齐

### 主题
- [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme) (**默认**)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [catppuccin](https://github.com/catppuccin/nvim)
- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim)
- [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
- [nordic.nvim](https://github.com/AlexvZyl/nordic.nvim)
- [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
- [sonokai](https://github.com/sainnhe/sonokai)
- [onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [newpaper.nvim](https://github.com/yorik1984/newpaper.nvim)

### 其他
- [nvterm](https://github.com/NvChad/nvterm) — 终端管理
- [project.nvim](https://github.com/ahmedkhalf/project.nvim) — 项目管理
- [hex.nvim](https://github.com/RaafatTurki/hex.nvim) — 十六进制编辑
- [DoxygenToolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim) — Doxygen 注释
- [vista.vim](https://github.com/liuchengxu/vista.vim) — 标签查看器
- [conflict-marker.vim](https://github.com/rhysd/conflict-marker.vim) — Git 冲突标记
- [vim-beancount](https://github.com/nathangrigg/vim-beancount) — Beancount 记账语法
- [markview.nvim](https://github.com/OXY2DEV/markview.nvim) — Markdown 预览
- [mini.diff](https://github.com/echasnovski/mini.diff) — 内联 Diff
- [img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim) — 图片粘贴

</details>

## 自定义

### 切换主题

编辑 `lua/config.lua`：

```lua
g.theme = "tokyonight"    -- 可选: github_dark, dracula, catppuccin-mocha, gruvbox-material, nordic 等
g.background = "dark"     -- dark 或 light
```

### 添加 LSP 服务器

1. 在 `lua/plugins/mason.lua` 的 `ensure_installed` 表中添加服务器名称
2. 在 `lua/plugins/lspconfig.lua` 的 `servers` 表中添加相同名称

```lua
-- lua/plugins/mason.lua
local ensure_installed = {
    -- ... 已有服务器
    "rust_analyzer",  -- 新增
}

-- lua/plugins/lspconfig.lua
local servers = { "lua_ls", "bashls", "rust_analyzer" }  -- 新增
```

### 添加格式化工具

在 `lua/plugins/mason.lua` 的 `null_ls_install_list` 中添加，并在 `lua/plugins/none_ls.lua` 中配置源。

### 本地覆盖（不提交到 Git）

创建 `lua/custom.lua`（已 gitignored），用于存放机器特定的配置：

```lua
local M = {}

M.get_beancount = function()
    return '/your/custom/path/main.bean'
end

return M
```

### 切换缩进方式

```vim
:IndentToggle
```

## 项目结构

```
~/.config/nvim/
├── init.lua                  # 入口文件
├── lazy-lock.json            # 插件版本锁定（已 gitignore）
├── lua/
│   ├── config.lua            # 编辑器选项、全局变量、Leader 键
│   ├── mappings.lua          # 所有快捷键定义
│   ├── icons.lua             # 图标定义
│   ├── custom.lua            # 本地覆盖配置（已 gitignore）
│   └── plugins/
│       ├── init.lua          # 插件列表（lazy.nvim 入口）
│       ├── lspconfig.lua     # LSP 配置
│       ├── mason.lua         # Mason 安装管理
│       ├── none_ls.lua       # 格式化配置
│       ├── treesitter.lua    # 语法高亮配置
│       ├── telescope.lua     # 搜索配置
│       ├── blink.lua         # 补全配置
│       ├── lualine.lua       # 状态栏配置
│       ├── bufferline.lua    # Buffer 标签栏配置
│       ├── nvimtree.lua      # 文件树配置
│       ├── gitsigns.lua      # Git 状态配置
│       ├── codecompanion.lua # AI 助手配置
│       └── ...               # 其他插件配置
```

## 自定义命令

| 命令 | 说明 |
|------|------|
| `:IndentToggle` | 切换 Tab/Space 缩进 |
| `:MasonInstallAll` | 安装所有格式化工具 |
| `:NvimTreeToggle` | 切换文件树 |
| `:Telescope` | 打开 Telescope 搜索 |
| `:Lazy` | 打开插件管理器 |
| `:LazyGit` | 打开 LazyGit |
| `:DiffviewOpen` | 打开 Diff 视图 |
| `:Outline` | 打开代码大纲 |

## License

[GPL-3.0](LICENSE)
