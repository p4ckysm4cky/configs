# Aliases
alias cdf='cd $(find . -maxdepth 1 -mindepth 1 -type d | fzf --preview "tree -L 3 -C {} | head -300")'
alias cdff='cd $(find . -mindepth 1 -type d | fzf --preview "tree -L 3 -C {} | head -300")'
alias vimf='vim $(fzf --preview "batcat --style=numbers --color=always {} | head -500")'

# Functions
bwcwd() {
    bwrap \
        --ro-bind / / \
        --bind "$PWD" "$PWD" \
        --chdir "$PWD" \
        --tmpfs /tmp \
        --proc /proc \
        --dev /dev \
        --share-net \
        "${@:-/bin/sh}"
}

bwcwdagent() {
    bwrap \
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
        "${@:-/bin/sh}"
}

pi() {
    bwcwdagent pi "$@"
}

# Yazi: return to the browsed directory on q; Q keeps the current directory.
y() {
    local yazi_tmp yazi_cwd yazi_exit
    yazi_tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
    command yazi "$@" --cwd-file="$yazi_tmp"
    yazi_exit=$?
    IFS= read -r -d '' yazi_cwd < "$yazi_tmp" || true
    if [ -n "$yazi_cwd" ] && [ "$yazi_cwd" != "$PWD" ] && [ -d "$yazi_cwd" ]; then
        builtin cd -- "$yazi_cwd"
    fi
    command rm -f -- "$yazi_tmp"
    return "$yazi_exit"
}

# Setup starship
eval "$(starship init bash)"

# Setup Zoxide
eval "$(zoxide init bash)"
