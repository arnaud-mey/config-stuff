# The following lines were added by compinstall
zstyle :compinstall filename '/home/arnaudmeyer/.zshrc'
ZSH=/usr/share/oh-my-zsh/
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if ! [[ -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
ZSH_THEME="sunaku"
export EDITOR="emacs"
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

alias gia='git add'
alias gic='git commit -m'
alias gis='git status'
alias gips='git push'
alias gip='git pull'
alias gich='git checkout'
alias gib='git branch'
alias gif='git diff'

alias kc='kubectl'

alias venv='if [[ -d venv ]]; then source ./venv/bin/activate; else virtualenv venv && source ./venv/bin/activate; fi'

export FZF_COMPLETION_TRIGGER="**"
export FZF_DEFAULT_OPTS='--no-height'

export GOPATH="$HOME/basteln/golang"
export GOROOT=/usr/lib/go

source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# End of lines configured by zsh-newuser-install
alias ipdsh="noglob ipdsh"
