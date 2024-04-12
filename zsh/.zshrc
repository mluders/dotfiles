# Terminal

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HISTSIZE=99999999
export SAVEHIST=$HISTSIZE
export EDITOR=nvim

# Zsh

export CASE_SENSITIVE="false" # Use case-insensitive completion.
export ZSH_THEME="robbyrussell"
export ZSH="$HOME/.oh-my-zsh"
plugins=(asdf iterm-tab-color)
source $ZSH/oh-my-zsh.sh
alias zshrc="code ~/.zshrc"
eval "$(fzf --zsh)" # fzf shell integration
alias vim='nvim'

# Git

alias g="git"
alias ga="git add"
alias gb="git branch"
alias gbb="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gc="git commit"
alias gcan="git commit --amend --no-edit"
alias gco="git checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias gf="git fetch"
alias gg="git grep"
alias gl="git log"
alias gm="git merge"
alias gpl="git pull"
alias gpu="git push"
alias grb="git rebase"
alias grs="git reset"
alias gs="git status"
alias GS="git status"
alias gsh="git show"
alias gw="git whatchanged"
alias pr="gh pr view -w"
alias repo="gh repo view -w"
alias sw="git switch -"
alias wip="git commit -m 'wip'"

# Rails

export DISABLE_SPRING=1

alias be='bundle exec'
alias tl='test_launcher'
alias htl='HEADLESS=false test_launcher'
alias brake='bundle exec rake'
alias bmy='bundle; brake db:migrate; yarn'
alias mig="bundle exec rails db:migrate"
alias migtest="bundle exec rails db:migrate RAILS_ENV=test"
alias rol="bundle exec rails db:rollback STEP=1"
alias rol2="bundle exec rails db:rollback STEP=2"
alias purge-dev='bundle exec rails db:migrate:reset RAILS_ENV=development'
alias purge-test='bundle exec rails db:migrate:reset RAILS_ENV=test'

tldiff() {
  git diff --name-only $1 HEAD | grep "test\.rb$" | xargs test_launcher
}

alias fs="foreman start"
alias fsweb="foreman start all=0,web=1"
alias fspack="foreman start all=0,webpacker=1"
alias fsother="foreman start all=1,web=0,webpacker=0"

[ -f ".zshrc-appfolio" ] && source .zshrc-appfolio
