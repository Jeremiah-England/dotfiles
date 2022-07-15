# Defined in /tmp/fish.IO2SMv/pyexit.fish @ line 2
function pyexit
    if set -q VIRTUAL_ENV
        deactivate
    else
        echo "Not in a virtual environment."
    end
end
