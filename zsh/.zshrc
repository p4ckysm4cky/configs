# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit
bindkey -e
bindkey -M emacs '^[[1;3D' backward-word
bindkey -M emacs '^[[1;3C' forward-word

# PATH
export PATH="$HOME/.local/bin:$HOME/.fzf/bin:$PATH"

# Editor
export EDITOR=nvim
export VISUAL=nvim

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colors and basic aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Optional shared aliases
[ -f ~/.aliases ] && source ~/.aliases

# Aliases
if ! command -v bat >/dev/null 2>&1 && command -v batcat >/dev/null 2>&1; then
    alias bat='batcat'
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# fzf
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# fzf-tab previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --style=numbers --color=always $realpath 2>/dev/null || batcat --style=numbers --color=always $realpath 2>/dev/null || ls --color=always $realpath'

# fzf-tab
if [ -f "$HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh" ]; then
    source "$HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh"
fi
# Functions
# Permissive development agent sandbox
bwagentdev() {
    bwrap \
        --unshare-all \
        --ro-bind / / \
        --bind-try "$HOME/.config/opencode" "$HOME/.config/opencode" \
        --bind-try "$HOME/.local/share/opencode" "$HOME/.local/share/opencode" \
        --bind-try "$HOME/.cache/opencode" "$HOME/.cache/opencode" \
        --bind-try "$HOME/.pi/agent" "$HOME/.pi/agent" \
        --bind "$PWD" "$PWD" \
        --chdir "$PWD" \
        --tmpfs /tmp \
        --proc /proc \
        --dev /dev \
        --share-net \
        --die-with-parent \
        "${@:-/bin/sh}"
}

pi() {
    bwagentdev pi "$@"
}

# Shared guarded sandbox policy with network access and minimal host mounts.
_bwguard() {
    bwrap \
        --unshare-all \
        --share-net \
        --unshare-user \
        --disable-userns \
        --clearenv \
        --setenv HOME "$HOME" \
        --setenv PATH /usr/bin \
        --setenv TERM "${TERM:-xterm-256color}" \
        --setenv COLORTERM truecolor \
        --setenv LANG "${LANG:-C.UTF-8}" \
        --setenv XDG_CACHE_HOME /tmp/cache \
        --ro-bind /usr /usr \
        --ro-bind /lib /lib \
        --ro-bind /lib64 /lib64 \
        --ro-bind /etc/ssl/certs /etc/ssl/certs \
        --ro-bind /etc/resolv.conf /etc/resolv.conf \
        --bind "$PWD" "$PWD" \
        --chdir "$PWD" \
        --tmpfs /tmp \
        --proc /proc \
        --dev /dev \
        --new-session \
        --die-with-parent \
        "${@:-/usr/bin/sh}"
}

bwguard() {
    _bwguard -- "${@:-/usr/bin/sh}"
}

piguard() {
    if [[ -z ${NVM_BIN:-} ]]; then
        print -u2 'piguard: NVM_BIN is not set'
        return 1
    fi

    local node_root=${NVM_BIN:h}

    _bwguard \
        --ro-bind "$node_root" "$node_root" \
        --bind "$HOME/.pi/agent" "$HOME/.pi/agent" \
        --setenv PATH "$NVM_BIN:/usr/bin" \
        -- pi "$@"
}

# Zoxide
eval "$(zoxide init zsh)"

# Starship prompt
eval "$(starship init zsh)"
