
# 🚀 Development Workflow Guide (Sabbir)

````markdown

A clean, fast, and scalable command workflow for:
- Claude Code (Free Proxy Setup)
- Auto Code Reviewer
- Authority Counter Solver
- Python Environment Handling

---

# ⚙️ 1. Bash Configuration (`~/.bashrc`)

## 🔧 Add the Following

```bash
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
  source .virtual/bin/activate
}

# ================================
# 🤖 AUTO CODE REVIEW RUNNER
# ================================

function crun() {
  cra
  echo "⚙️ Running Code Reviewer..."
  python main.py --repo ftpsofts/Home_Chef_20_04_2026 --branch FrontendFinal/G4 --only resources/js/themes/HomeChefTheme
}

# ================================
# 🧠 AUTHORITY COUNTER SOLVER
# ================================

function acs() {
  cd ~/auto/Authority-Counter-Review-Solver || return
  echo "🚀 Starting Authority Counter Solver..."
  python main.py
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
````

---

## 🔄 Apply Changes

```bash
source ~/.bashrc
```

---

# 🤖 2. Claude Code Workflow

## ⚡ Quick Start (Recommended)

```bash
ccc
```

✔ Starts proxy
✔ Launches Claude

---

## 🔹 Manual Mode

### Step 1: Go to server

```bash
dcc
```

### Step 2: Run proxy

```bash
pcc
```

### Step 3: Run Claude

```bash
cc
```

---

## 🧪 Sandbox Setup

Inside Claude UI:

```
/sandbox
```

* Select **Option 1**

---

## 🧠 Model Selection

```
/model
```

* Choose **Option 1 (Opus)**
* Nvidia-backed (fast + free tier)

---

# 🐍 3. Code Review Agent

## ⚡ One Command Run

```bash
crun
```

✔ Navigate to project
✔ Activate virtual environment
✔ Run reviewer

---

## 🔹 Manual Mode

### Step 1: Go to project

```bash
cd ~/auto/code-review-agent
```

### Step 2: Activate environment

```bash
source .virtual/bin/activate
```

### Step 3: Run script

```bash
python main.py --repo ftpsofts/Home_Chef_20_04_2026 --branch FrontendFinal/G4 --only resources/js/themes/HomeChefTheme
```

---

# 🧠 4. Authority Counter Solver

## ⚡ One Command Run

```bash
acs
```
dev-workflow.md
---

## 🔹 Manual Mode

### Step 1: Go to project

```bash
cd ~/auto/Authority-Counter-Review-Solver
```

### Step 2: Run script

```bash
python main.py
```

Then input:

```
Project folder path:
```

---

# 🐍 5. Python Behavior

```bash
python
```

✔ Automatically runs `python3`
✔ Set via:

```bash
alias python='python3'
```

---

# 🧩 6. Command Summary

| Command | Purpose                |
| ------- | ---------------------- |
| `dcc`   | Go to Claude server    |
| `pcc`   | Start proxy            |
| `ccs`   | Go + start proxy       |
| `cc`    | Run Claude             |
| `ccc`   | Full Claude automation |
| `cra`   | Code review env setup  |
| `crun`  | Run code reviewer      |
| `acs`   | Run authority solver   |

---

# ⚠️ Best Practices

* Use **functions instead of aliases** for multi-step workflows
* Always ensure proxy is running before Claude (or use `ccc`)
* Keep environments isolated using `.virtual`
* Use one-command shortcuts to reduce repetitive work

---

# 🚀 Future Improvements (Optional)

* Auto project detection (`dev review`, `dev claude`)
* Convert into reusable CLI tool
* Add `direnv` for auto virtual environment activation
* Script-based full automation (`setup.sh`)

---

# ✅ Final Notes

This workflow is designed for:

* ⚡ Speed (one-command execution)
* 🧠 Clarity (readable + maintainable)
* 🔧 Scalability (easy to extend)

Maintain this file as your **single source of truth** for dev operations.

