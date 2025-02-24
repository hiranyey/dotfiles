export ZSH="$HOME/.oh-my-zsh"
eval "$(starship init zsh)"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias uu="sudo apt update && sudo apt upgrade -y"

export PATH="$PATH:/home/hiranyey/.local/bin"
export PATH=$PATH:/usr/local/go/bin
export GOPATH="/home/hiranyey/.go"
export PATH=$PATH:$GOPATH/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PNPM_HOME="/home/hiranyey/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
