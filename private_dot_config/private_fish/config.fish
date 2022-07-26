if status is-interactive
    # Commands to run in interactive sessions can go here

    # PS1='($?) $(tput setaf 5)\u$(tput sgr0):$(tput setaf 3)\w$(tput sgr0)\$ '

    set -x PATH ~/.local/bin $PATH
    set -x PATH ~/Documents/github/Jeremiah-England/exercism-scripts/scripts $PATH
    set -x PATH "$HOME/.cargo/bin" $PATH

    # source ~/.bash_aliases

    set -x PRINTER Brother_HL_L2390DW

    if test -e ~/.gitlab-secrets.fish
        source ~/.gitlab-secrets.fish
    end

    if test -e ~/gitlab/vs/raillinks-infra/tools/unix-scripts/rc-files/vs-rc.fish
        source ~/gitlab/vs/raillinks-infra/tools/unix-scripts/rc-files/vs-rc.fish
    end

    set -x EDITOR nvim
    set -x VISUAL nvim

    # See https://github.com/ajeetdsouza/zoxide#step-2-add-zoxide-to-your-shell
    if command -s zoxide
        zoxide init fish | source
    end

    fish_vi_key_bindings

    # From https://wiki.archlinux.org/title/Node.js
    set -x npm_config_prefix "$HOME/.local"

    abbr -a fic fish_rc
    abbr -a gds git diff --staged
    abbr -a gf git fetch
    abbr -a gap git add . -p
end
