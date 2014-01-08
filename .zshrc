which uname > /dev/null
if [ $? -eq 0 ]; then
    case `uname` in
        "Linux")
            alias ls='ls --color=auto' ;;
        "Darwin")
            echo "On Mac OS X"
            alias ls='ls -G';;
        *)
            echo `uname` " is not supported";;
    esac
else
    echo "uname is not available, please report"
fi

alias ll='ls -la'
alias lt='ls -lt'

## histroy
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

## bind keys as Emacs
bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

autoload -U promptinit
promptinit
prompt redhat

## 'command not found' hood
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

## Dirstack Configuration
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
test -d `dirname $DIRSTACKFILE` || mkdir -p `dirname $DIRSTACKFILE` 
test -f $DIRSTACKFILE || touch $DIRSTACKFILE
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
    print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
setopt pushdignoredups
setopt pushdminus
