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

# Setup starship
eval "$(starship init bash)"

# Setup Zoxide
eval "$(zoxide init bash)"