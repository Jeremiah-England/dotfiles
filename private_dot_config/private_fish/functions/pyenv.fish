function pyenv
    if test ! -d venv
        if test ! -d .git
            read answer -P 'You are not at a root directory of a git repository. Do you want to proceed? [Y/n] '
            if string match -rq '^[^Yy]' "$answer"  # If $answer is empty then this does not match, so Y is the default.
                return 0
            end
        end
        virtualenv venv
        source venv/bin/activate.fish
        if test -f requirements.txt
            pip install -r requirements.txt
        end
        if test -f requirements-dev.txt
            pip install -r requirements-dev.txt
        end
    else
        source venv/bin/activate.fish
    end
end
