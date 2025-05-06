# Personal neovim configs

This is a personal Neovim configuration built with Lua, designed for a productive and enjoyable coding experience. It incorporates a variety of plugins and settings to enhance functionality and aesthetics.

## 🚀 Features

-   **Core Configuration:**
    -   `options.lua`: Configures basic Neovim settings and options.
    -   `keymaps.lua`: Defines custom key mappings for improved navigation and workflow.

-   **Plugin Management:**
    -   `plugins-setup.lua`: Manages plugin installation and loading using a plugin manager.

-   **Language Server Protocol (LSP):**
    -   `lspconfig.lua`: Configures LSP settings for various languages, providing features like auto-completion, diagnostics, and code formatting.

-   **Completion Framework:**
    -   `nvim-cmp.lua`: Configures the `nvim-cmp` completion plugin for intelligent code completion.

-   **Fuzzy Finder:**
    -   `telescope.lua`: Sets up Telescope for fast file searching, buffer management, and more.

-   **Visual Enhancements:**
    -   `indent-blankline.lua`: Configures indent blanklines for improved code readability.
    -   `gruvbox.lua`: Applies the Gruvbox colorscheme for a visually appealing interface.
    -   `bufferline.lua`: Configures the bufferline plugin for managing open buffers.
    -   `lualine.lua`: Configures the lualine plugin for a customizable statusline.

-   **Utility Plugins:**
    -   `comment_nvim.lua`: Configures `comment.nvim` for easy code commenting.
    -   `nvim-tree.lua`: Sets up `nvim-tree` for file system navigation.
    -   `autopairs.lua`: Configures automatic bracket and quote pairing.
	-   `project.lua`: Configures project management.
	-   `git.lua`: Configures git-related plugins.

-   **Custom Configurations:**
    -   `configs/plugins/avante.lua`: Custom configurations for the Avante plugin.

## 🛠️ Installation

1.  **Prerequisites:**
    -   Neovim (v0.5 or higher)
    -   A plugin manager (e.g., [vim-plug](https://github.com/junegunn/vim-plug), [lazy.nvim](https://github.com/folke/lazy.nvim))

2.  **Clone the Repository:**

    ```bash
    git clone <repository_url> ~/.config/nvim
    ```

3.  **Install Plugins:**

    Open Neovim and run the plugin installation command for your plugin manager (e.g., `:PlugInstall` for vim-plug, `:Lazy` for lazy.nvim).

## ⚙️ Usage

-   Explore the `lua/core/keymaps.lua` file to discover useful key mappings.
-   Customize plugin settings in the respective files within the `lua/plugins/` directory.
-   Use the `:Telescope` command to access Telescope's features.

## 📂 File Structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── core/
│   │   ├── options.lua
│   │   └── keymaps.lua
│   ├── plugins/
│   │   ├── plugins-setup.lua
│   │   ├── lspconfig.lua
│   │   ├── .
│   │   ├── .
│   │   ├── .
│   │   └── avante.lua 
│   └── configs/
│       └── plugins/
│           └── avante.lua
└── README.md
```

