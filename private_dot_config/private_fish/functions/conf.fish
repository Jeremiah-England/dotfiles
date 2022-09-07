function conf
    set file (fd . ~/.config --type file --exclude={'libreoffice','Microsoft','Signal','chromium','discord'} | fzf --query $argv[1])
    if test -n "$file"
        $EDITOR $file
    end
end
