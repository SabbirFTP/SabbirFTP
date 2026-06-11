# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Created by `pipx` on 2025-12-08 04:12:51
export PATH="$PATH:/home/sabbir/.local/bin"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools



# ================================================================================================================= S
# ================================================================================================================= A
# ================================================================================================================= B
# ================================================================================================================= B
# ================================================================================================================= I
# ================================================================================================================= R



# ================================
# 🚀 CLAUDE CODE WORKFLOW
# ================================

# Go to Claude server directory
alias dcc='cd ~/auto/free-claude-code'

# Start Claude proxy (manual)
alias pcc='uv run uvicorn server:app --host 0.0.0.0 --port 8082'

# Run Claude CLI
alias cc='ANTHROPIC_AUTH_TOKEN="freecc" ANTHROPIC_BASE_URL="http://localhost:8082" claude --dangerously-skip-permissions'

# 🔥 Combined: Go + Run Proxy
function ccs() {
  cd ~/auto/free-claude-code || return
  echo "🚀 Starting Claude Proxy Server..."
  uv run uvicorn server:app --host 0.0.0.0 --port 8082
}

# ================================
# 🐍 PYTHON ENV HELPERS
# ================================

# Force python -> python3
alias python='python3'

# Go to Code Review Agent + Activate venv
function cra() {
  cd ~/auto/code-review-agent || return
  echo "🐍 Activating virtual environment..."
  source .venv/bin/activate
}


# ================================
# 🤖 AUTO CODE REVIEW RUNNER
# ================================

function crun() {
  cra
  echo "⚙️ Running Code Reviewer..."
  # python3 main.py --repo ftpsofts/REPO_URL --branch BRANCH/NAME --only SPECIFIC_PATH_TO_CHECK
}

# ================================
# 🤖 AUTO CODE REVIEW RUNNER FOR SABBIR
# ================================

function sabbir() {

    # Config
    local repo_path="ftpsofts/Fintech_Point_Website"
    local branch="mms-dev"
    local file_path="resources/views/themes/standard"

    # Activate virtual environment
    cra || {
        echo "Failed to activate virtual environment"
        return 1
    }

    echo "================================="
    echo "Running Code Review Agent"
    echo "================================="
    echo "Repo Path : $repo_path"
    echo "Branch    : $branch"
    echo "File Path : $file_path"
    echo "Checking codes..."
    echo

    # Run script
    python3 main.py \
        --repo "$repo_path" \
        --branch "$branch" \
        --only "$file_path"
}

bappy() {
    # Config
    local repo_path="ftpsofts/graphql-faysal"
    local branch="main"
    local file_path="app"

    # Activate virtual environment
    cra || {
        echo "Failed to activate virtual environment"
        return 1
    }

    echo "================================="
    echo "Running Code Review Agent"
    echo "================================="
    echo "Repo Path : $repo_path"
    echo "Branch    : $branch"
    echo "File Path : $file_path"
    echo "Checking codes..."
    echo

    # Run script
    python3 main.py \
        --repo "$repo_path" \
        --branch "$branch" \
        --only "$file_path"
}

function alamin() {
  cra
  echo "⚙️ Running Code Reviewer..."
  # python3 main.py --repo ftpsofts/Home-Chef-Cloud-by-Sabbir-x-Ashik --branch user --only lib/features/user
  
  python3 main.py --repo ftpsofts/FTP_softs_protfolio --branch alamin --only plugins
}


# ================================
# 🤖 AUTO CODE REVIEW RUNNER FOR ARNAB
# ================================
function arnob() {
  cra
  echo "⚙️ Running Code Reviewer..."
  python3 main.py --repo ftpsofts/Home_Chef_20_04_2026 --branch testmeF --only resources/views/themes
}

# OPEN REPORT FOLDER
alias report='xdg-open ~/auto/code-review-agent/reports'


# ================================
# 🧠 AUTHORITY COUNTER SOLVER
# ================================

function acs() {
  cd ~/auto/Authority-Counter-Review-Solver || return
  echo "🚀 Starting Authority Counter Solver..."
  python3 main.py
}

# ================================
# ⚡ CLAUDE QUICK START (FULL FLOW)
# ================================

function ccc() {
  echo "🚀 Booting Claude Environment..."
  
  cd ~/auto/free-claude-code || return
  
  # Run proxy in background
  echo "🔌 Starting Proxy..."
  uv run uvicorn server:app --host 0.0.0.0 --port 8082 &
  
  sleep 2
  
  echo "🤖 Launching Claude..."
  ANTHROPIC_AUTH_TOKEN="freecc" ANTHROPIC_BASE_URL="http://localhost:8082" claude --dangerously-skip-permissions
}



# OPEN CROME OFFICE PROFILE
alias oc='google-chrome --profile-directory="Profile 2"'

alias file='xdg-open .'

# OPEN BASHRC IN CODE
alias rc='code ~/.bashrc'


# function ar() {
  # 设置 AgentRouter 的 API 基础 URL

  # # 设置您的 AgentRouter API 密钥, 可以从 https://agentrouter.org/console/token 获取
  # export ANTHROPIC_BASE_URL="https://agentrouter.org/v1"
  # export ANTHROPIC_AUTH_TOKEN="sld3tk84oVTkDxkGfKeiN46A+gbx5o4="
  # export ANTHROPIC_API_KEY="sk-BWbCAibKJjAxRkChSQ1o5PUqK2AMVph9GHimhDwBWwMDKJhv"z
  # export ANTHROPIC_MODEL="claude-opus-4-6"
  export ANTHROPIC_MODEL="claude-haiku-4-5-20251001"
  # export CLAUDE_CODE_USE_AUTH_TOKEN="false"
# }

alias rcf='source ~/.bashrc'

function zc() {
  cd ~/auto/cracker || return

  # ---------------- ENV CHECK ----------------
  if [ ! -d "venv" ]; then
    echo -e "\033[1;31m[ ERROR ]\033[0m Virtual environment not found!"
    echo "Run: python3 -m venv venv"
    return
  fi

  # ---------------- BOOT SEQUENCE ----------------
  echo -e "\n\033[1;32m[ ZC ]\033[0m Initializing Zip Cracker Pro..."
  sleep 0.2

  echo -ne "[+] Boot sequence starting...\r"
  sleep 0.2
  echo -e "[✔] Boot sequence complete     "

  echo -ne "[+] Injecting runtime environment...\r"
  sleep 0.3
  echo -e "[✔] Environment injected       "

  echo -ne "[+] Loading cryptographic modules...\r"
  sleep 0.3
  echo -e "[✔] Modules loaded             "

  echo -ne "[+] Activating AES engine...\r"
  sleep 0.3
  echo -e "[✔] AES engine online          "

  echo -ne "[+] Preparing attack vectors...\r"
  sleep 0.3
  echo -e "[✔] Attack vectors ready       "

  # ---------------- DIVIDER ----------------
  echo -e "\n----------------------------------------"
  echo -e "▄︻デ══━一💥  ZC ENGINE ONLINE  💥━══━"
  echo -e "----------------------------------------"

  # ---------------- VENV ACTIVATION ----------------
  echo -e "\033[1;36m[ ENV ]\033[0m Activating virtual environment..."
  source venv/bin/activate

  sleep 0.2

  echo -e "\033[1;32m[ READY ]\033[0m System ready. Awaiting target input...\n"

  # ---------------- RUN ----------------
  python zip_cracker_pro.py
}

# Added by Antigravity CLI installer
export PATH="/home/sabbir/.local/bin:$PATH"
alias ag='"/home/sabbir/applications/Antigravity IDE/antigravity-ide" --no-sandbox'
alias agx='"/home/sabbir/applications/Antigravity/antigravity" --no-sandbox'
