#!/usr/bin/env bash
set -u

PYTHON_BIN="$(command -v python3 || command -v python || true)"

if [[ -z "$PYTHON_BIN" ]]; then
  echo "[devcontainer] ERROR: Weder python3 noch python gefunden."
  exit 1
fi

log() {
  echo "[devcontainer] $(date '+%H:%M:%S') $1"
}

install_python_pkg() {
  local pkg="$1"
  log "pip install $pkg ..."
  if "$PYTHON_BIN" -m pip install --quiet "$pkg"; then
    log "OK: $pkg"
  else
    log "WARN: $pkg konnte nicht installiert werden"
  fi
}

install_npm_pkg() {
  local pkg="$1"
  log "npm install -g $pkg ..."
  if npm install -g "$pkg" --silent; then
    log "OK: $pkg"
  else
    log "WARN: $pkg konnte nicht installiert werden"
  fi
}

# ---------------------------------------------------------------------------
log "=== Devcontainer Setup gestartet ==="

# ---------------------------------------------------------------------------
log "--- pip / setuptools aktualisieren ---"
"$PYTHON_BIN" -m pip install --quiet --upgrade pip setuptools wheel

# ---------------------------------------------------------------------------
log "--- Python-Pakete installieren ---"
install_python_pkg aider-chat
install_python_pkg litellm
install_python_pkg openai
install_python_pkg google-genai

# ---------------------------------------------------------------------------
log "--- npm-Pakete installieren ---"
install_npm_pkg @openai/codex

# ---------------------------------------------------------------------------
log "--- Docker-Verfügbarkeit prüfen ---"
if command -v docker >/dev/null 2>&1; then
  docker --version || true
  if docker info >/dev/null 2>&1; then
    log "Docker Daemon erreichbar (DooD aktiv)"
  else
    log "WARN: Docker CLI verfügbar, aber kein Daemon erreichbar"
  fi
else
  log "WARN: Docker CLI nicht gefunden"
fi

# ---------------------------------------------------------------------------
log "--- Tool-Versionen ---"
"$PYTHON_BIN" --version || true
node --version           || true
npm --version            || true
aider --version          || true
codex --version          || true

log "=== Devcontainer Setup abgeschlossen ==="
