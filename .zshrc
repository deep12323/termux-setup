[ -x "$HOME/.termux/bin/apply-active-palette" ] && "$HOME/.termux/bin/apply-active-palette" 2>/dev/null
# ============================================================
#  Enhanced Modern Zsh Configuration — Synced for Termux & PRoot
# ============================================================

# ── 1. Environment & Colors ──────────────────────────────────
export TERM="xterm-256color"
export COLORTERM="truecolor"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nano"
export VISUAL="nano"

# Bat Theme
export BAT_THEME="Catppuccin Mocha"

# Path Configuration
export PATH="/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/home/.termux/bin:/data/data/com.termux/files/home/.local/bin:/usr/local/bin:/root/.local/bin:/root/.termux/bin:$HOME/.local/bin:$HOME/.termux/bin:$PATH"

# ── 2. Tab Completion & Zstyle Styling ───────────────────────
autoload -Uz compinit
compinit -d "$HOME/.zcompdump" -C

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'
zstyle ':completion:*:messages' format '%F{purple}── %d ──%f'
zstyle ':completion:*:warnings' format '%F{red}── No matches found ──%f'

setopt AUTO_CD              # Type directory name to cd into it directly
setopt AUTO_MENU            # Show completion menu on successive tabs
setopt COMPLETE_IN_WORD     # Complete from cursor position
setopt ALWAYS_TO_END        # Move cursor to end of word after completion
setopt NO_CASE_GLOB         # Case-insensitive globbing
setopt GLOB_DOTS            # Match hidden files in globbing
setopt EXTENDED_GLOB        # Extended glob syntax

# ── 3. History Settings ──────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ── 4. Keybindings ───────────────────────────────────────────
bindkey -e  # Emacs keybindings default

# Cursor and line editing
bindkey '^[[H' beginning-of-line       # Home
bindkey '^[[F' end-of-line             # End
bindkey '^[[3~' delete-char            # Delete
bindkey '^[[1;5C' forward-word         # Ctrl + Right
bindkey '^[[1;5D' backward-word        # Ctrl + Left
bindkey '^H' backward-kill-word        # Ctrl + Backspace
bindkey '^[[3;5~' kill-word            # Ctrl + Delete

# ── 5. Zsh Plugins ───────────────────────────────────────────
# Autosuggestions
for _as_path in \
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/data/data/com.termux/files/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/data/data/com.termux/files/home/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  if [ -f "$_as_path" ]; then
    ZSH_AUTOSUGGEST_STRATEGY=(history)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086,bold"
    source "$_as_path" 2>/dev/null || true
    unset ZSH_AUTOSUGGEST_USE_ASYNC
    unset ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE
    bindkey '^[[C' autosuggest-accept 2>/dev/null || true
    bindkey '^[OC' autosuggest-accept 2>/dev/null || true
    bindkey '^F' autosuggest-accept 2>/dev/null || true
    bindkey '^E' autosuggest-accept 2>/dev/null || true
    bindkey '^@' autosuggest-accept 2>/dev/null || true
    bindkey '^[[F' autosuggest-accept 2>/dev/null || true
    bindkey '^[OF' autosuggest-accept 2>/dev/null || true
    bindkey '^[[1;5C' forward-word 2>/dev/null || true
    bindkey '^[f' forward-word 2>/dev/null || true
    break
  fi
done

# ── 6. FZF Fuzzy Finder Integration ──────────────────────────
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi --height=45% --layout=reverse --border=rounded --info=inline-right"

  export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --level=2 --color=always --icons {} 2>/dev/null || ls -la {}; else bat --style=numbers --color=always --line-range :200 {} 2>/dev/null || cat {}; fi'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons {} 2>/dev/null || ls -la {}'"

  source <(fzf --zsh 2>/dev/null) || true
fi

# ── 7. Zoxide (Smart cd) ─────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# ── 8. Starship Prompt ───────────────────────────────────────
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ── 9. Syntax Highlighting (Loaded after all widgets) ─────────
typeset -gA ZSH_HIGHLIGHT_STYLES 2>/dev/null || true
typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS 2>/dev/null || true
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)

ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89dceb,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#cba6f7,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f9e2af'
ZSH_HIGHLIGHT_STYLES[path]='fg=#94e2d5,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'

for _sh_path in \
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/data/data/com.termux/files/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/data/data/com.termux/files/home/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
  if [ -f "$_sh_path" ]; then
    _sh_dir="${_sh_path:h}"
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$_sh_dir/highlighters"
    source "$_sh_path" 2>/dev/null || true
    for _hl in main brackets cursor; do
      _hl_file="$ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR/$_hl/$_hl-highlighter.zsh"
      [ -f "$_hl_file" ] && . "$_hl_file" 2>/dev/null || true
    done
    break
  fi
done

# ── 9. Modern Aliases ────────────────────────────────────────
# File listing with Eza
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --git --group-directories-first --time-style=relative'
  alias la='eza -a --icons --group-directories-first'
  alias l='eza -lh --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons --group-directories-first'
  alias tree='eza --tree --icons'
else
  alias ls='ls --color=auto'
  alias ll='ls -laF --color=auto'
  alias la='ls -A --color=auto'
  alias l='ls -CF --color=auto'
fi

# Cat replacement with Bat
if command -v bat &>/dev/null; then
  alias cat='bat --style=plain --paging=never'
  alias preview='bat --style=numbers --color=always'
elif command -v batcat &>/dev/null; then
  alias cat='batcat --style=plain --paging=never'
  alias preview='batcat --style=numbers --color=always'
fi

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias c='clear'
alias cls='clear'
alias q='exit'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'

# System utilities
alias fetch='fastfetch'
alias theme='termux-theme'
alias myip='echo -n "Public IP: " && curl -s https://api.ipify.org && echo "" && echo "Local IP:" && (ifconfig 2>/dev/null | grep -E "inet [0-9.]+" || ip a | grep inet)'
alias ports='ss -tulpn 2>/dev/null || netstat -tulanp 2>/dev/null || lsof -i'
alias df='df -h'
alias du='du -h -d 1'
alias free='free -h'

# Antigravity CLI
[ -x "/root/.local/bin/agy" ] && alias agy="/root/.local/bin/agy"

# ── 10. Helpful Functions ────────────────────────────────────
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"        ;;
      *.tar.gz)    tar xzf "$1"        ;;
      *.bz2)       bunzip2 "$1"        ;;
      *.rar)       unrar x "$1"        ;;
      *.gz)        gunzip "$1"         ;;
      *.tar)       tar xf "$1"         ;;
      *.tbz2)      tar xjf "$1"        ;;
      *.tgz)       tar xzf "$1"        ;;
      *.zip)       unzip "$1"          ;;
      *.Z)         uncompress "$1"     ;;
      *.7z)        7z x "$1"           ;;
      *.tar.xz)    tar xf "$1"         ;;
      *.tar.zst)   tar --zstd -xf "$1" ;;
      *)           echo "Cannot extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

mkcd() {
  mkdir -p "$1" && cd "$1"
}

cheat() {
  curl -s "cheat.sh/${1}"
}

weather() {
  curl -s "wttr.in/${1:-}?m"
}

bak() {
  cp -r "$1" "${1}.bak" && echo "✔ Backed up $1 → ${1}.bak"
}

# ── 11. Welcome Dashboard ────────────────────────────────────
if [[ -o interactive ]]; then
  if command -v fastfetch &>/dev/null; then
    fastfetch
  elif [[ -f "$HOME/.termux/banner.sh" ]]; then
    bash "$HOME/.termux/banner.sh"
  fi
fi
