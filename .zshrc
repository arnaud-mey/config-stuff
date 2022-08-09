# The following lines were added by compinstall
zstyle :compinstall filename '/home/arnaudmeyer/.zshrc'
ZSH=~/.oh-my-zsh/
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

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/Users/ameyer/Library/Python/3.8/bin:$PATH"

export GOPATH="$HOME/basteln/golang"
export GOROOT=/usr/lib/go

source ~/.oh-my-zsh/oh-my-zsh.sh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh

source <(kubectl completion zsh)

# End of lines configured by zsh-newuser-install
alias ipdsh="noglob ipdsh"

complete -C '/opt/homebrew/bin/aws_completer' aws

py2() {
  sudo unlink /usr/local/bin/python ; sudo ln -s "${HOME}/.pyenv/versions/2.7.18/bin/python2.7" "/usr/local/bin/python"
  export PATH=$(echo $PATH | sed 's#/Users/ameyer/Library/Python/[2-9]\.[0-9]/bin#/Users/ameyer/\.pyenv/versions/2\.7\.18/bin#g')
}

py3() {
  export PATH=$(echo $PATH | sed 's#Python/[2-9]\.[0-9].?[0-9]?/bin#Python/3.8/bin#g')
}

okta_assume_template() {
  export AWS_DEFAULT_REGION="eu-central-1"
  oktapwd=$(security find-generic-password -a arnaud.meyer@ppro.com -s okta-aws-cli -w)
  okta-awscli --okta-profile ${1} -P $oktapwd --cache
  if [ -s ~/.okta-credentials.cache ]
  then
      source ~/.okta-credentials.cache
      rm -rf ~/.okta-credentials.cache
  fi
}
ppro_security() {
    okta_assume_template ppro_security
}
ppro_logging() {
     okta_assume_template ppro_logging
}
ppro_production() {
    okta_assume_template ppro_production
}
ppro_infrastructure() {
    okta_assume_template ppro_infrastructure
}
ppro_dev() {
     okta_assume_template ppro_development
}
ppro_staging() {
     okta_assume_template ppro_staging
}

ppro_aslan_argon_dev() {
     okta_assume_template ppro_aslan_argon_dev
}
