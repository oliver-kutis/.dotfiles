
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kutis/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kutis/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kutis/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kutis/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Set path to node
export PATH="/usr/local/opt/node@18/bin:$PATH"

# I honestly don't know what this is
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set home to taskfile (this doesn't seem to be correct TBH :D)
export TASKFILE_HOME=/Users/kutis/Documents/Github/gauss-algo-hw/bin
