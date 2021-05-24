#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

# FZF stuff
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --type d $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview '([[ -d {} ]] && tree -aC {}) || ([[ -f {} ]] && bat --color=always --style=header,grid --line-range :300 {})'"
export FZF_ALT_C_COMMAND="fd --type f --hidden $FD_OPTIONS"

# NNN
if (( $+commands[kitty] )); then
	export NNN_PLUG='o:fzopen;v:preview-kitty'
fi
export NNN_FIFO=/tmp/nnn.fifo

# Command execution time stamp shown in the history command output.
HIST_STAMPS="yyyy/mm/dd"

# Plugins to load
plugins=(
	aws
	docker
	fd
	gitfast
	golang
	npm
	pass
	pyenv
	pylint
	sudo
	vi-mode
    virtualenv
)

source $ZSH/oh-my-zsh.sh
source ~/.powerlevel9k_config
if [ -d /usr/local/Cellar/ ]; then
	source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh ] && source ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh
[ -f /usr/share/vim/vimfiles/gruvbox_256palette.sh ] && source /usr/share/vim/vimfiles/gruvbox_256palette.sh
[ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)

bindkey -v # vi mode

if (( $+commands[kitty] )) && [[ $TERM -eq xterm-kitty ]]; then
	kitty + complete setup zsh | source /dev/stdin
fi

if (( $+commands[kitty] )); then
	alias icat="kitty +kitten icat"
	alias issh="kitty +kitten ssh"
fi

# Aliases for a few useful commands
alias ls="exa"
alias la="exa -a"
alias ll="exa -aglh"
alias ip="ip -c"
alias rm="rm -i"
alias cat="bat"
alias vim="nvim"

# Work
export PATH=$HOME/.toolbox/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit
complete -C '/usr/local/bin/aws_completer' aws

# Finalize
autoload -Uz compinit && compinit
