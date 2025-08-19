export HOMEBREW_NO_AUTO_UDPATE=1 # Disable auto-update for homebrew
export ZAITRA_DATA_PATH="$HOME/data/zaitra"
export DOTFS="$HOME/code/.dotfiles"

# <<< 
# >>> Powerlevel10k and other prompt configurations
# <<<
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/powerlevel10k/config/p10k-rainbow.zsh.
#[[ ! -f ~/powerlevel10k/config/p10k-rainbow.zsh ]] || source ~/powerlevel10k/config/p10k-rainbow.zsh

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
alias ls="eza"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

# Add pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

# export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/node@20/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/node@20/include"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/kutis/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kutis/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/kutis/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kutis/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/code/.dotfiles/.p10k.zsh.
[[ ! -f ~/code/.dotfiles/.p10k.zsh ]] || source ~/code/.dotfiles/.p10k.zsh

# AWS CLI to Path
export PATH=/usr/local/bin/aws:$PATH

### gcloud & gsutil CLI
# Which python version should the gcloud cli use 
export CLOUDSDK_PYTHON=$(pyenv which python)
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/oliver/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/oliver/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/oliver/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/oliver/google-cloud-sdk/completion.zsh.inc'; fi
