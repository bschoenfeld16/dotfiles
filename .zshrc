# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/schoen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	zsh-autosuggestions
	osx
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
 
###########################
#ALIASES
###########################
alias ll='ls -alF'
alias c='clear'

## Git Aliases ##
alias gs='git status'
alias gc='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gbr='git branch -r'
alias gba='git branch -a'
alias ga='git add'
alias gaa='git add --all'
alias gpush='git push'
alias gpull='git pull'
alias gpullum='git pull upstream master'
alias grm='git branch --merged >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'
alias gl='git lg'
alias grpo='git remote prune origin'
alias gmm='git merge main'
alias gau='git add -u'


## Spring Boot Aliases ##
alias refreshclient='curl -X POST http://dev-sc-wrapper-laww-config.ocp-elr-core-nonprod.optum.com/actuator/refresh'
alias refreshlocalclient='curl -X POST http://localhost:8088/actuator/refresh'

## Aliases to switch java versions ##
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias j13="export JAVA_HOME=`/usr/libexec/java_home -v 13`; java -version"

## File compare Alias ##
#alias compareFiles='perl -ne 'print if ($seen{$_} .= @ARGV) =~ /10$/''


alias py='python3'

## docker Aliases ##
alias di='docker images'
alias dp='docker ps'
alias dpa='docker ps -a'
alias dka="docker kill \$(docker ps -q)"
alias drma="docker rm \$(docker ps -a -q)"

## k8 Aliases ##
alias k='kubectl'

## digiocean Aliases ##
alias digiprimary='ssh root@157.245.245.149'


###########################
#PATHS
###########################
export PATH=/Users/schoen/apache-maven-3.5.2/bin:$PATH

###########################
#CUSTOM FUNCTIONS
###########################
## parseGitBranch #
parseGitBranch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
## decrypt #
dec() {
	spring decrypt "$1" --key "OHBS-PORTAL-$2"
}

## encrypt #
enc() {
	spring encrypt "$1" --key "OHBS-PORTAL-$2"
}

## Find processes listening on a port #
findproc() {
	lsof -n -i4TCP:"$1" | grep LISTEN
}

## search for local git branch#
gbs() {
	git branch | grep -i "$1"
}

## search for remote git branch#
gbrs() {
	git branch -r | grep -i "$1"
}

## removes a tag remotely and locally
grt() {
	tag="$1"
	git push --delete origin $tag
	git tag -d $tag
}

nptp() {
	nonprod=$(spring decrypt "$1" --key "OHBS-PORTAL-NONPROD")
	prod=$(spring encrypt "$nonprod" --key "OHBS-PORTAL-PROD!")
	echo $prod
}

trustlist() {
	keytool -list -v -keystore "$1" -storepass "$2"
}

ocl() {
	if [ $1 = "dev" ]; then
		oc login https://ocp-elr-core-nonprod.optum.com
		oc project ohbs-msapps-dev
	elif [ $1 = "tst" ]; then
		oc login https://ocp-elr-core-nonprod.optum.com
		oc project ohbs-msapps-test
	elif [ $1 = "stgelr" ]; then
		oc login https://origin-elr-core.optum.com
		oc project ohbs-msapps-stage
	elif [ $1 = "stgctc" ]; then
		oc login https://origin-ctc-core.optum.com
		oc project ohbs-msapps-stage
	fi
}

dbash() {
	docker exec -it "$1" /bin/bash
}

kbash() {
	kubectl exec -it "$1" /bin/bash
}

drbash() {
	docker run -it "$1" /bin/bash
}

dk() {
	docker kill "$1"
}

dirm() {
	docker image rm "$1"
}

kuc() {
	if [ $1 = "ed" ]; then
		kubectl config use-context elrihr-ihr-b50-iae-dev
	elif [ $1 = "et" ]; then
		kubectl config use-context elrihr-ihr-b50-iae-tst
	elif [ $1 = "cd" ]; then
		kubectl config use-context ctcihr-ihr-b50-iae-dev
	fi
}

PROMPT='%{$fg_bold[magenta]%}%n%{$fg[green]%}@%{$fg[cyan]%}%m:%{$fg[green]%}%d%{$reset_color%} $(git_prompt_info)
%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔"
