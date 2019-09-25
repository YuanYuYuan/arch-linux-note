export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bullet-train"

## Bullet train theme
BULLETTRAIN_PROMPT_ORDER=(
    # context
    status
    git
    dir
    cmd_exec_time
)

## zsh plugins
plugins=(
    git
    history-substring-search
    git
    autojump
    history
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    sudo
    zsh-completion-generator
)


# source configures
source "$ZSH/oh-my-zsh.sh"
source "$HOME/.aliases"
source "$HOME/.functions"

export PATH="/usr/lib/ccache/bin/:$PATH"
export VISUAL="vim"
export GOPATH=~/go
export EDITOR="/usr/bin/vim"
export TERMINAL='/usr/bin/alacritty'
export BROWSER="/usr/bin/firefox"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/Workings/scripts"
export PATH="$PATH:$HOME/.local/bin"


if [[ "$TERM" =~ "xterm" ]]; then
    export TERM=xterm-256color
elif [ "$TERM" = "screen" -o "$TERM" = "screen-256color" ]; then
    export TERM=screen-256color
    unset TERMCAP
fi

export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export XDG_CONFIG_HOME="$HOME/.config"

# disable Software Flow Control (XON/XOFF flow control)
stty -ixon

# completion
autoload -U compinit && compinit

# enable completion after =
setopt magicequalsubst

# history settings
export HIST_STAMPS="mm/dd/yyyy"
export HISTSIZE=999999999
export SAVEHIST=999999999

# plugin; history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

