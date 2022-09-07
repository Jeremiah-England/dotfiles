function git-push-origin
    git push -u origin (git branch | grep '^*' | cut -c 3-)
end
