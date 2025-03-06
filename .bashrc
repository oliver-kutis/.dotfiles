# Completions for Taksfile
eval "$(task --completion bash)"
export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/node@20/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@20/include"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kutis/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kutis/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/kutis/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kutis/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Add pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
