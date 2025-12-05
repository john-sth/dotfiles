#==============================================================
# .zshrc
#==============================================================


# optional: install packages 
# zsh-autosuggestions, zsh-syntax-highlighting

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

#================================
# switch to home dir with ALT+H
#================================
bindkey -s '\eh' 'cd ~\n'


export XDG_CONFIG_HOME=$HOME/.config

# Use ++ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='++'

#=======================================================
# Colorscheme PS1
#=======================================================
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#=======================================================
# play tetris in command line :)
#=======================================================
autoload -Uz tetriscurses

#=======================================================
# Basic auto/tab complete:
#=======================================================
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

#=======================================================
# History store outside of config 
#=======================================================

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$HOME/.local/share/zsh_history"

bindkey -r '^[[C'
bindkey '^F' autosuggest-accept

#=======================================================
# executes fo (fzf script) in .local/bin
#=======================================================
fo-widget() {
   $HOME/.local/bin/fo 
}
zle -N fo-widget

#=======================================================
# Bind ZLE Widget to Keybinding
#=======================================================
bindkey '^F' fo-widget

#=======================================================
# fix slow zsh autocompletion for adding files in git 
#=======================================================
__git_files () { 
    _wanted files expl 'local files' _files     
}

#=======================================================
# vi mode
#=======================================================
bindkey -v
export KEYTIMEOUT=40
export EDITOR=vim

# Use vim keys in tab complete menu:
bindkey -M viins jj vi-cmd-mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

## dirstack

autoload -Uz add-zsh-hook

DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi
chpwd_dirstack() {
	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
}
add-zsh-hook -Uz chpwd chpwd_dirstack

DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

# https://that.guru/blog/automatically-set-tmux-window-name/
case "$TERM" in
linux|xterm*|rxvt*)
    export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}: ${PWD##*/}\007"'
    ;;
    screen*)
    export PROMPT_COMMAND='echo -ne "\033k${HOSTNAME%%.*}: ${PWD##*/}\033\\" '
    ;;
    *)
    ;;
esac

#=======================================================
# Remove duplicate entries
#=======================================================
setopt PUSHD_IGNORE_DUPS

#=======================================================
# This reverts the +/- operators.
#=======================================================
setopt PUSHD_MINUS

#sxhkd &
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share:$PATH

#=======================================================
# use less and bat for syntax highlighting in man pages 
#=======================================================
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPAGER="less -R --use-color -Dd+r -Du+b"

#=======================================================
# git function for doing add, commit and push in one go
#=======================================================
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

#=======================================================
# zoxide and fzf 
#=======================================================
eval "$(zoxide init zsh)"

export FZF_DEFAULT_OPTS="--preview 'cat {}' --bind 'ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up' --border=rounded"

source /usr/share/fzf/examples/completion.zsh
source /usr/share/fzf/examples/key-bindings.zsh 


source $HOME/.aliasrc
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
