# 🚀 Enhanced Terminal Setup — by deepu2135

An aesthetic, ultra-fast, and modern terminal environment designed for **Termux**, **PRoot Ubuntu / Debian**, and **Linux**.

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Termux%20%7C%20Linux%20%7C%20PRoot-orange.svg)
![Theme](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-magenta.svg)

---

## ✨ Features

- ⚡ **Starship Prompt:** Fast, context-aware prompt showing User, Git branch & status (`⇡`/`⇣`/`!`/`+`), Python/Node/Rust/Java versions, and command duration timer.
- 📊 **Fastfetch System Dashboard:** Real-time Memory, Device Storage, and accurate PRoot container footprint.
- 🎨 **12 Designer Color Themes & Starship Presets:** Built-in one-command switcher (`theme`) supporting Catppuccin Mocha, Catppuccin Latte, Tokyo Night, Dracula, Gruvbox Dark, Nord, Rosé Pine, Kanagawa, Cyberpunk, One Dark, Hacker Green, and Termux Default with instant OSC terminal palette repaint.
- 🔮 **Fish-style Syntax Highlighting & Autosuggestions:** Fast, reliable command autocompletion (`Right Arrow`, `Ctrl + F`, `Ctrl + E`, or `Ctrl + Space` to accept; `Ctrl + Right` or `Alt + F` for word-by-word accept).
- 🔍 **Interactive FZF Integration:**
  - `Ctrl + R`: Interactive fuzzy search through command history.
  - `Ctrl + T`: File search with live syntax-highlighted `bat` previews.
  - `Alt + C`: Directory search with live `eza` tree previews.
- 📁 **Modern CLI Utilities:** `eza` (modern `ls` with icons & git status), `bat` (syntax-highlighted `cat`), `zoxide` (`z` smart directory jumping).
- 📱 **Welcome Dashboard & Status Banner:** Beautiful ASCII system status banner and Fastfetch card.

---

## 📦 Repository Structure

```text
termux-setup/
├── install.sh                  # Universal 1-command installer
├── .zshrc                      # Enhanced Zsh configuration
├── .bashrc                     # Enhanced Bash configuration
├── config/
│   ├── starship.toml           # Starship prompt configuration
│   ├── fastfetch/
│   │   └── config.jsonc        # Fastfetch card dashboard
│   └── bat/
│       └── config              # Bat syntax theme settings
└── termux/
    ├── banner.sh               # Welcome banner & system status
    ├── bin/
    │   ├── termux-theme        # Interactive & CLI theme switcher
    │   ├── apply-active-palette# OSC live palette synchronizer
    │   ├── proot-storage-info  # Accurate storage reporter
    │   └── update-proot-cache  # Background cache updater
    ├── colors/                 # 12 color schemes (.properties)
    └── themes/                 # Starship prompt themes (.starship.toml)
```

---

## 🚀 Quick Install

### One-line Installation:
```bash
git clone https://github.com/deepu2135/termux-setup.git
cd termux-setup
bash install.sh
```

Then start a fresh session or run:
```bash
exec zsh
```

---

## 🎨 Theme Switcher

Switch terminal color schemes anytime using:
```bash
theme
```

Or switch directly:
```bash
theme tokyonight
theme dracula
theme gruvbox-dark
theme nord
theme rose-pine
theme kanagawa
theme cyberpunk
theme catppuccin-mocha
theme random
```

---

## ⌨️ Shortcuts & Aliases

| Command | Action |
| :--- | :--- |
| `ls`, `l`, `la` | Modern file list with icons via `eza` |
| `ll` | Detailed list with Git status and human-readable dates |
| `lt` / `tree` | Tree directory structure with icons |
| `cat <file>` | Syntax-highlighted file viewing via `bat` |
| `z <dir>` | Smart directory jump via `zoxide` |
| `Ctrl + R` | Fuzzy history search |
| `Ctrl + T` | Fuzzy file search with preview |
| `fetch` | Display system & storage dashboard |
| `extract <file>` | Universal archive extractor |
| `mkcd <dir>` | Create directory and `cd` into it |
| `bak <file>` | Backup file to `.bak` |

---

## 🛠️ Stack

- **Shell:** [Zsh](https://www.zsh.org/) / [Bash](https://www.gnu.org/software/bash/)
- **Prompt:** [Starship](https://starship.rs/)
- **Fetch:** [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- **File Preview:** [Bat](https://github.com/sharkdp/bat) & [Eza](https://github.com/eza-community/eza)
- **Fuzzy Finder:** [FZF](https://github.com/junegunn/fzf)
- **Navigation:** [Zoxide](https://github.com/ajeetdsouza/zoxide)

---

> Made with ❤️ by [@deepu2135](https://github.com/deepu2135)
