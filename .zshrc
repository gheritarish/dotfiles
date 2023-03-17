# source <(curl -sL git.io/zi-loader); zzinit
typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

# Plugins
zi ice wait'1' lucid
zi snippet OMZP::fzf
zi ice wait'1' lucid
zi snippet OMZP::git

zi ice wait'1' lucid
zinit light sunlei/zsh-ssh

zi ice wait'2' lucid
zi snippet OMZP::sudo

zi ice wait lucid
zi light Aloxaf/fzf-tab
zi wait lucid atload"zicompinit; zicdreplay" blockf for Aloxaf/fzf-tab

zi light zsh-users/zsh-syntax-highlighting


zi ice as"completion"
zi snippet OMZP::docker-compose/_docker-compose

# History
zi snippet OMZL::history.zsh
zi snippet OMZL::completion.zsh
zi snippet OMZL::directories.zsh
zi snippet OMZL::functions.zsh
zi snippet OMZL::grep.zsh
zi snippet OMZL::git.zsh
zi snippet OMZL::key-bindings.zsh

setopt auto_cd

# Powerlevel10k
setopt prompt_subst
zi light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias ls="lsd"
alias dnd="source ~/dnd/bin/activate"
alias deact="deactivate"
alias pgadmin="source ~/pgadmin4/bin/activate && pgadmin4"
alias sshgit="~/.git.sh"
alias clscr="~/clean_screenshots"
alias srce="source /etc/grc.zsh"
alias jdr="cd ~/Documents/JDR/DnD/New_campaign"
alias emacs="emacs -nw"
alias vim="nvim"

export PATH=/home/telmar/.local/bin:/home/telmar/.local/share/gem/ruby/3.0.0/bin:/home/telmar/.cargo/bin:/home/telmar/.dotnet:$PATH
export GPG_TTY=$(tty)
export XDG_CONFIG_HOME=/home/telmar/.config
export EDITOR=nvim

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=-R

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

eval "$(ssh-agent -s)" > /dev/null

export _JAVA_AWT_WM_NONREPARENTING=1

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets regexp)
typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=(' -{1,2}[a-zA-Z0-9_-]*' fg=008)

# Fzf tab configuration
# disable sort when completing `git checkout/show/commit`
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-show:*' sort false
zstyle ':completion:*:git-commit:*' sort false
zstyle ':completion:*:git-diff:*' sort false
zstyle ':completion:*:git-format-patch:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
