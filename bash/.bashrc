# Setup Zoxide
eval "$(zoxide init bash)"

# Aliases
alias cdf='cd $(find . -maxdepth 1 -type d ! -name '.' | fzf --preview "tree -L 3 -C {} | head -300")'
alias cdff='cd $(find . -type d | fzf --preview "tree -L 3 -C {} | head -300")'
alias vimf='vim $(fzf --preview "batcat --style=numbers --color=always {} | head -500")'