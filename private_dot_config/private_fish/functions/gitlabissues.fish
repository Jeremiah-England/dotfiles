function gitlabissues
    glab issue view (glab issue list | fzf | rg -P '(?<=#)\d+' -o) $argv
end
