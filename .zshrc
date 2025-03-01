# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


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

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/node@20/lib"
export CPPFLAGS="-I/opt/homebrew/opt/node@20/include"
export HOMEBREW_NO_AUTO_UDPATE=1 # Disable auto-update for homebrew

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kutis/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kutis/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kutis/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kutis/google-cloud-sdk/completion.zsh.inc'; fi
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/powerlevel10k/config/p10k-rainbow.zsh.
[[ ! -f ~/powerlevel10k/config/p10k-rainbow.zsh ]] || source ~/powerlevel10k/config/p10k-rainbow.zsh

export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.14
export PATH="$JAVA_HOME/bin/:$PATH"

export SPARK_HOME=/opt/homebrew/Cellar/apache-spark/3.5.4/libexec
export PATH="$SPARK_HOME/bin/:$PATH"

# Add PySpark to PYTHONPATH
export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH"
export TASKFILE_HOME=/Users/kutis/Documents/Github/gauss-algo-hw/bin

# Completions for taskfile
eval "$(task --completion zsh)"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
# Navigate by word using Option+Left/Right
bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word
# Delete previous word using Option+Backspace
bindkey "\e\177" backward-kill-word
# Clear entire line using Cmd+Backspace (sends ^U, which is common for kill-whole-line)
bindkey "\u0015" kill-whole-line

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
