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

export GOPATH="$HOME/code"



source ~/.oh-my-zsh/oh-my-zsh.sh
#source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
#source /opt/homebrew/opt/fzf/shell/completion.zsh

source <(kubectl completion zsh)

# End of lines configured by zsh-newuser-install
alias ipdsh="noglob ipdsh"

complete -C '/usr/local/bin/aws_completer' aws

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

aws-ssh(){
  instance_name=${1}
  instance_id=$(aws ec2 describe-instances --filter "Name=private-dns-name,Values=${instance_name}" --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" --output text)
  aws ssm start-session --target ${instance_id}
}

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# BEGIN_AWS_SSO_CLI

# AWS SSO requires `bashcompinit` which needs to be enabled once and
# only once in your shell.  Hence we do not include the two lines:
#
# autoload -Uz +X compinit && compinit
# autoload -Uz +X bashcompinit && bashcompinit
#
# If you do not already have these lines, you must COPY the lines
# above, place it OUTSIDE of the BEGIN/END_AWS_SSO_CLI markers
# and of course uncomment it

__aws_sso_profile_complete() {
     local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    _multi_parts : "($(/usr/local/bin/aws-sso ${=_args} list --csv Profile))"
}

aws-sso-profile() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    if [ -n "$AWS_PROFILE" ]; then
        echo "Unable to assume a role while AWS_PROFILE is set"
        return 1
    fi
    eval $(/usr/local/bin/aws-sso ${=_args} eval -p "$1")
    if [ "$AWS_SSO_PROFILE" != "$1" ]; then
        return 1
    fi
}

aws-sso-clear() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error}
    if [ -z "$AWS_SSO_PROFILE" ]; then
        echo "AWS_SSO_PROFILE is not set"
        return 1
    fi
    eval $(/usr/local/bin/aws-sso ${=_args} eval -c)
}

get_pw () {
  security find-generic-password -ga "$1" -w
}

export_pw () {
  export $1=$(get_pw $1)
}

compdef __aws_sso_profile_complete aws-sso-profile
complete -C /usr/local/bin/aws-sso aws-sso

# END_AWS_SSO_CLI
