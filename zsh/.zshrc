# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HISTSIZE=99999999
export SAVEHIST=$HISTSIZE
export EDITOR=nvim

# Brew
export PATH="/opt/homebrew/bin:$PATH"

# Zsh
export CASE_SENSITIVE="false" # Use case-insensitive completion.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(asdf)
source $ZSH/oh-my-zsh.sh
alias zshrc="code ~/.zshrc"
eval "$(fzf --zsh)" # fzf shell integration
alias vi='nvim'
alias vim='nvim'
alias v='nvim'
alias vv='nvim .'
alias ts='tmux-sessionizer'

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

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

export GPG_TTY=$(tty)

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
[ -f ".zshrc.local" ] && source .zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
