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

# Setup starship
eval "$(starship init bash)"

# Setup Zoxide
eval "$(zoxide init bash)"