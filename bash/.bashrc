# Setup Zoxide
eval "$(zoxide init bash)"

# Aliases
alias cdf='cd $(find . -maxdepth 1 -type d ! -name '.' | fzf --preview "tree -a -C {} | head -200")'
alias cdff='cd $(find . -type d | fzf --preview "tree -a -C {} | head -200")'
alias vimf='vim $(fzf --preview "batcat --style=numbers --color=always {} | head -500")'