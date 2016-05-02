source ~/.bashrc

### Git Auto completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

### Aliases

alias vg='vagrant'

# Open specified files in Sublime Text
# "s ." will open the current directory in Sublime
alias s='open -a "Sublime Text"'
alias bp='vim ~/.bash_profile && source ~/.bash_profile'
alias bprofile='source ~/.bash_profile'

# Color LS
colorflag="-G"
# ${colorflag}
alias ls="command ls -GF "
alias l="ls -lGF " # all files, in long format
alias la="ls -laGF " # all files inc dotfiles, in long format
alias lsd='ls -lGF | grep "^d"' # only directories

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."
alias ............="cd ../../../../../../../../../../.."
alias .............="cd ../../../../../../../../../../../.."


# Alias to salt developer
alias salt="cd ~/salt-developer"
alias saltssh="cd ~/salt-developer && vagrant ssh"
alias saltup="cd ~/salt-developer && vagrant up"
alias salthalt="cd ~/salt-developer && vagrant halt"
alias vssh="vgutil ssh"
alias update="cd ~/salt-developer && vgutil update"
alias highstate="cd ~/salt-developer && vgutil highstate"

# Shortcuts to folders in my home directory
alias code="cd ~/salt-developer/code"
alias site="cd ~/salt-developer/code/site"
alias qapi="cd ~/salt-developer/code/api/questionsV2"
alias qt="cd ~/salt-developer/code/api/questionsV2/www/latest/tests"
alias qeapi="cd ~/salt-developer/code/api/questioneditor"
alias aapi="echo asapi or auapi"
alias auapi="cd ~/salt-developer/code/api/author"
alias asite="cd ~/salt-developer/code/site/author"
alias sapi="cd ~/salt-developer/code/api/schemas"
alias asapi="cd ~/salt-developer/code/api/assess/"
alias assess="cd ~/salt-developer/code/api/assess/"
alias scoring="cd ~/salt-developer/code/service/scoring"
alias iapi="cd ~/salt-developer/code/api/items"
alias api="cd ~/salt-developer/code/api/"
alias rapi="cd ~/salt-developer/code/api/reports"
alias docs="cd ~/salt-developer/code/site/docs"
alias iso="cd ~/salt-developer/code/site/docs/www/demos/isolation"
alias isor="cd ~/salt-developer/code/site/docs/www/demos/isolation/regions"
alias demos="cd ~/salt-developer/code/site/demos"
alias dapi="cd ~/salt-developer/code/api/data"
alias libscoring="cd ~/salt-developer/code/api/questionsV2/www/latest/vendor/scoring"
alias sstates="cd ~/salt-developer/code/salt-states"
alias mathquill="cd ~/workspace/mathquill"
alias rui="./node_modules/.bin/grunt php:test:keepalive"
alias tui="vgtest run -t test-ui-env -b chrome -e vg"
alias vpnp="echo shanty census freeware homesick"

alias vgupdate="! lsof ~/salt-developer/code/ && cd ~/salt-developer && git checkout master && git pull && ! ./scripts/upgrade-salt-dev 3"
alias vgreboot="! lsof ~/salt-developer/code/ && cd ~/salt-developer && vagrant halt && vagrant up"

alias bridget="salt && echo y | ./scripts/enable-bridge \$(route get google.com | grep interface | sed s/interface:\ //)"

#Shortcut to the script to connect to the VPN when working from home
alias sydvpn="cd ~ && osascript sydneyOffice.scpt"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias c='pygmentize -O style=monokai -f console256 -g'

# Git
# You must install Git first - ""
alias gs='git status'
alias gadd='git add ' # . or something specific
alias gcommit='git commit -m' # requires you to type a commit message
alias gpush='git push origin ' # branch name
alias gsu='git submodule update'
alias gp='git pull && gsu && git status'
alias gpb='git pull && gsu && vgbuild dev && git status'
alias v2dev='git checkout V2-develop && gpb'
alias dev='git checkout develop && gpb'
alias gbranch='git branch'
alias deletebranch='git branch -D ' # branch name
alias gstash='git stash'
alias v3dev='git checkout V3-develop && gpb'
alias mw='vgutil ssh && make watch'

gc() {
    git checkout $1
    git submodule update
    vgutil ssh
}

### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
        BLACK=$(tput setaf 190)
        MAGENTA=$(tput setaf 9)
        ORANGE=$(tput setaf 172)
        GREEN=$(tput setaf 190)
        PURPLE=$(tput setaf 141)
        WHITE=$(tput setaf 0)
    else
        BLACK=$(tput setaf 190)
        MAGENTA=$(tput setaf 5)
        ORANGE=$(tput setaf 4)
        GREEN=$(tput setaf 2)
        PURPLE=$(tput setaf 1)
        WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    BLACK="\033[01;30m"
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡ "

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# init z! (https://github.com/rupa/z)
#. ~/z.sh

function vboxstop() {
    sudo /Library/"Application Support"/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh stop
}

function vboxstart() {
    sudo /Library/"Application Support"/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh start
}

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi


export PATH=/usr/local/bin:$PATH
#export PATH="$(brew --prefix php55)/bin:$PATH"

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

export PATH=$PATH:/Users/corey/salt-developer/scripts

export HISTCONTROL=ignoreboth:erasedups # skip lines starting with space or duplicates
export HISTSIZE=100000                  # big big history
export HISTFILESIZE=100000              # big big history
shopt -s histappend                     # append to history, don't overwrite it

# Save the history after each command finishes
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

alias brn='for dirname in */; do cd $dirname; if [[ "* develop" != `git branch` ]] ; then echo -e "  /${PWD##*/}\n" `git branch --list | egrep --color=always "\*"` ; fi; cd ..; done'

alias brew="sudo chown -R `whoami`:admin /usr/local; brew"

#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e vim' # quick opening files with vim