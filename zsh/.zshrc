setopt share_history

export GPG_TTY=$(tty)


# Terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HISTSIZE=99999999
export SAVEHIST=$HISTSIZE
export EDITOR=nvim

# Local scripts
export PATH="$HOME/.local/scripts:$PATH"

# Brew
export PATH="/opt/homebrew/bin:$PATH"

# Zsh
export CASE_SENSITIVE="false" # Use case-insensitive completion.
alias vi='nvim'
alias vim='nvim'
alias vv='nvim .'
alias vf='source sessionizer 1'
alias f='source sessionizer'

# Pure zsh prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

# fzf
export ESCDELAY=0 # Remove escape key delay
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)" # fzf shell integration

# Up arrow history completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# asdf
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath) # append completions to fpath
autoload -Uz compinit && compinit # initialise completions with ZSH's compinit

# General
alias ll="ls -la"

# Git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gbb="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gc="git commit"
alias gca="git commit --amend"
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
alias gsw="git switch -"
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

[ -f "$HOME/.zshrc-local" ] && source $HOME/.zshrc-local
[ -f "$HOME/.zshrc-appfolio" ] && source $HOME/.zshrc-appfolio
