function pyenv
    if test ! -d venv
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
