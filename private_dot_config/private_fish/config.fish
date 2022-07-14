if status is-interactive
    # Commands to run in interactive sessions can go here

    # PS1='($?) $(tput setaf 5)\u$(tput sgr0):$(tput setaf 3)\w$(tput sgr0)\$ '

    set -x PATH ~/.local/bin $PATH
    set -x PATH ~/Documents/github/Jeremiah-England/exercism-scripts/scripts $PATH
    set -x PATH "$HOME/.cargo/env" $PATH

    # source ~/.bash_aliases

    set -x PRINTER Brother_HL_L2390DW

    source ~/.gitlab-secrets.fish
    source ~/gitlab/vs/raillinks-infra/tools/unix-scripts/rc-files/vs-rc.fish

    set -x EDITOR nvim
    set -x VISUAL nvim

    # See https://github.com/ajeetdsouza/zoxide#step-2-add-zoxide-to-your-shell
    zoxide init fish | source

    fish_vi_key_bindings

    # From https://wiki.archlinux.org/title/Node.js
    set -x npm_config_prefix "$HOME/.local"

    abbr -a fic fish_rc
    abbr -a gds git diff --staged
end
