# Voraussetzungen und Setup

> Ziel: In unter 15 Minuten sicherstellen, dass alle Teilnehmenden das Hands-on-Lab reproduzierbar starten und ausführen können.

Dieses Dokument ist die **zentrale Anlaufstelle** für alle technischen Voraussetzungen, Tool-Stacks, API-Keys und Konfigurationsschritte der Hands-on-Labs.

---

## 🐋 1. Pflicht-Voraussetzung: Docker

Für das Hands-on-Lab ist eine funktionierende Docker-Umgebung zwingend erforderlich. Die im Lab entwickelte Anwendung (FastAPI Backend + React Frontend + RAG-Pipeline) wird über Docker Compose gestartet und im Dev Container ausgeführt.

Bitte installiere Docker für dein Betriebssystem vor Beginn des Workshops:

*   **Windows:**
    *   Installiere [Docker Desktop für Windows](https://docs.docker.com/desktop/install/windows-install/).
    *   *Wichtig:* Stelle sicher, dass das **WSL 2 Backend** (Windows Subsystem for Linux) in den Docker-Einstellungen aktiviert ist und dass eine Linux-Distribution (z. B. Ubuntu) auf deinem System läuft.
*   **macOS:**
    *   Installiere [Docker Desktop für Mac](https://docs.docker.com/desktop/install/mac-install/).
    *   *Alternative:* Installiere [OrbStack](https://orbstack.dev/) als ressourcenschonenden, schnellen Docker-Ersatz für macOS.

---

## 🎯 2. Empfohlenes Setup für diesen Workshop

> **VS Code + Cline Extension + BYOK (OpenRouter) + kostenloses Nvidia-Modell**

Diese Kombination ist der **primäre empfohlene Stack** für das Hands-on-Lab, da sie vollständig kostenlos startet und alle Workshop-Features abdeckt:

| Komponente | Empfehlung | Begründung |
|:---|:---|:---|
| **IDE** | [VS Code](https://code.visualstudio.com/) | Kostenlos, plattformunabhängig, größte Extension-Auswahl |
| **Coding Agent** | [Cline Extension](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev) für VS Code | Open-Source, BYOK-fähig, MCP-nativ, Modell-agnostisch |
| **Modell-Anbieter** | [OpenRouter](https://openrouter.ai/) | BYOK-freundlich, ein API-Key für viele Modelle, Budget-Steuerung |
| **Empfohlenes Modell** | `nvidia/nemotron-3-ultra-550b-a55b:free` | **Kostenlos** über OpenRouter, leistungsstark für Coding-Aufgaben |

### Einrichtung in 3 Schritten

1. **VS Code** installieren (falls nicht vorhanden): [code.visualstudio.com](https://code.visualstudio.com/)
2. **Cline Extension** installieren: Im VS Code Extension-Marketplace nach "Cline" suchen und installieren.
3. **OpenRouter-Key** erstellen und in Cline konfigurieren:
   - Registrierung unter [openrouter.ai/keys](https://openrouter.ai/keys)
   - API-Key erstellen (kostenlos, kein Guthaben nötig für Free-Modelle)
   - In Cline als Provider `OpenRouter` wählen und `nvidia/nemotron-3-ultra-550b-a55b:free` als Modell einstellen

> **Hinweis:** Alle anderen Kombinationen aus IDE + Coding Agent sind selbstverständlich auch möglich. Siehe hierzu die BYOK-Matrix in Abschnitt 3 und die detaillierten API-Key-Anleitungen in Abschnitt 4.

---

## 🔌 3. „Bring your own subscription“-Modell

Wir unterstützen die freie Wahl des Abonnements und der Werkzeuge. Jeder Teilnehmende kann sein bereits vorhandenes Konto oder Abonnement (auch kostenlose Free Tiers) nutzen.

Die folgende Tabelle zeigt die Zuordnung von Abonnement-Provider zu bevorzugter IDE / Coding Agent und erklärt, wie die API-Inferenz für die eigene App (RAG/Chat-Pipeline) gelöst wird:

| Abonnement / Provider | Bevorzugte IDE / Coding Agent | API-Nutzung für eigene App (RAG/Chat) | Hinweise / Free Tier |
| :--- | :--- | :--- | :--- |
| **Google** | VS Code + Cline (mit Gemini) oder CLI-Agents | **Ja (mit Free Tier)** | Google AI Studio bietet einen sehr großzügigen kostenlosen API-Zugang für Gemini 2.0 Flash. Ideal für das Lab. |
| **Cursor** | Cursor IDE (mit Composer) | **Nein (nur für die IDE)** | Cursor bietet keinen API-Endpunkt für externe Apps. Für die RAG-App wird zusätzlich ein Google AI Studio API-Key (kostenlos) oder ein OpenRouter-Key empfohlen. |
| **GitHub** | VS Code (mit GitHub Copilot Extension) | **Ja (mit Free Tier)** | GitHub Models bietet kostenlosen API-Zugang zu ausgewählten Modellen (z. B. GPT-4o-mini) über GitHub-Token. |
| **Claude (Anthropic)** | VS Code (mit Cline/Claude Dev) oder Claude Code (CLI) | **Nein (kostenpflichtig)** | Anthropic bietet keinen permanenten Free Tier für die API (Guthaben aufladen erforderlich, min. 5$). Für die RAG-App wird Google AI Studio oder OpenRouter empfohlen. |
| **OpenAI** | VS Code (mit Codex Extension) | **Nein (kostenpflichtig)** | OpenAI bietet keinen permanenten Free Tier für die API (Guthaben aufladen erforderlich). Für die RAG-App wird Google AI Studio oder OpenRouter empfohlen. |

---

## 🧠 4. Inferenz für die eigene RAG-App (API & Token)

Die Anwendung, die im Lab gebaut wird (eine PDF-RAG-Pipeline mit Chat-UI), benötigt zur Laufzeit Zugriff auf ein LLM für die Beantwortung von Benutzerfragen. Da viele IDE-Abonnements (wie Cursor Pro oder Claude Pro) keinen externen API-Zugriff beinhalten, gibt es dafür folgende Inferenz-Optionen (alle gleichberechtigt – wähle, was zu dir passt):

1.  **Google AI Studio:** Bietet einen kostenlosen API-Zugang zu Gemini-Modellen (z. B. `gemini-2.0-flash`).
2.  **GitHub Models:** Wenn du einen GitHub-Account hast, kannst du einen kostenlosen Token erstellen, um Modelle wie `gpt-4o-mini` über den OpenAI-kompatiblen Endpoint von GitHub aufzurufen.
3.  **OpenRouter:** Bietet kostenlose Modelle (z. B. `nvidia/nemotron-3-ultra-550b-a55b:free`, `qwen/qwen3-coder:free` oder `meta-llama/llama-3-8b-instruct:free`). Alternativ kannst du ein kleines Guthaben (z. B. 10$ per Kreditkarte) aufladen, um unbegrenzten Zugriff auf leistungsstarke Modelle (wie `claude-3-5-sonnet`) ohne enge Free-Tier Limits zu erhalten.
4.  **Ollama (Lokal):** 100 % kostenfreie, lokale Ausführung. Erfordert die Installation von Ollama auf deinem Rechner und das Herunterladen eines Modells (z. B. `qwen3:8b`). Geeignet für Offline-Arbeit, erfordert jedoch entsprechende Hardware (CPU/GPU/RAM).

---

## 🛠️ 5. Schritt-für-Schritt-API-Key-Erstellung & Registrierung

### A) OpenRouter (Empfohlen für BYOK – Cline + VS Code)
*   **Registrierung & Keys:** [OpenRouter](https://openrouter.ai/)
*   **Schritte:**
    1. Registriere dich auf [OpenRouter](https://openrouter.ai/).
    2. Gehe zu den API-Keys unter [openrouter.ai/keys](https://openrouter.ai/keys).
    3. Klicke auf **Create key**.
    4. *Tipp:* Setze ein Budget-Limit für den Workshop (z. B. $5 oder $10), falls du Guthaben aufgeladen hast.
    5. Kopiere den Key und trage ihn in deine `.env` ein.
*   **Eintragen in `.env`:**
    ```bash
    OPENROUTER_API_KEY="DEIN_KEY"
    OPENROUTER_MODEL="nvidia/nemotron-3-ultra-550b-a55b:free"
    ```
*   **In Cline konfigurieren:**
    - API-Provider: `OpenRouter`
    - Modell: `nvidia/nemotron-3-ultra-550b-a55b:free`

### B) Google AI Studio (Alternative)
*   **Registrierung:** [Google AI Studio](https://aistudio.google.com/)
*   **API-Key-Verwaltung:** [API Key Manager](https://aistudio.google.com/app/apikey)
*   **Schritte:**
    1. Öffne [Google AI Studio](https://aistudio.google.com/) und melde dich mit deinem Google-Konto an.
    2. Bestätige ggf. die Nutzungsbedingungen.
    3. Öffne den API Key Manager unter [aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey).
    4. Klicke auf **Create API key**.
    5. Wähle ein bestehendes Google-Cloud-Projekt oder erstelle ein neues Projekt.
    6. Kopiere den erzeugten Key sofort und speichere ihn in deiner lokalen `.env`-Datei.
*   **Eintragen in `.env`:**
    ```bash
    GEMINI_API_KEY="DEIN_KEY"
    GEMINI_MODEL="gemini-2.0-flash"

    OPENAI_API_KEY="${GEMINI_API_KEY}"
    OPENAI_API_BASE="https://generativelanguage.googleapis.com/v1beta/openai"
    OPENAI_MODEL="gemini-2.0-flash"
    ```

### C) GitHub Models (Alternative)
*   **Einstieg:** [GitHub Marketplace Models](https://github.com/marketplace/models)
*   **Token erstellen:** [GitHub Settings Tokens](https://github.com/settings/tokens)
*   **Schritte:**
    1. Melde dich bei [GitHub](https://github.com/) an.
    2. Öffne die Token-Einstellungen unter [github.com/settings/tokens](https://github.com/settings/tokens).
    3. Klicke auf **Generate new token (classic)** oder **Fine-grained token**.
    4. Vergib einen Namen, setze ein Ablaufdatum und wähle minimale Rechte (für Models reicht Lesezugriff).
    5. Klicke auf **Generate token**, kopiere ihn sofort und speichere ihn lokal.
*   **Eintragen in `.env`:**
    ```bash
    GITHUB_TOKEN="DEIN_TOKEN"
    GITHUB_MODELS_BASE="https://models.inference.ai.azure.com"
    GITHUB_MODELS_MODEL="gpt-4o-mini"
    ```

### D) Anthropic (Optional für fortgeschrittene Setups)
*   **Registrierung:** [Anthropic Console](https://console.anthropic.com/)
*   **Schritte:**
    1. Registriere dich auf [console.anthropic.com](https://console.anthropic.com/).
    2. Gehe zu **Settings** -> **Keys**.
    3. Erstelle einen API-Key, kopiere ihn und trage ihn in deine `.env` ein.
*   **Eintragen in `.env`:**
    ```bash
    ANTHROPIC_API_KEY="DEIN_KEY"
    ```

### E) Ollama (Lokal, ohne Cloud-Key)
*   **Download & Modelle:** [Ollama](https://ollama.com/)
*   **Schritte:**
    1. Lade Ollama von [ollama.com](https://ollama.com/) herunter und installiere es.
    2. Starte Ollama lokal auf deinem Rechner.
    3. Lade das gewünschte Modell über das Terminal herunter:
       ```bash
       ollama pull qwen3:8b
       ```
*   **Eintragen in `.env`:**
    ```bash
    OLLAMA_HOST="http://127.0.0.1:11434"
    OLLAMA_MODEL="qwen3:8b"
    ```

---

## 📋 6. Pre-Lab-Checkliste (Fail-fast)

Führe diese Befehle in deinem Terminal aus, bevor du mit dem Lab startest. So stellst du sicher, dass deine lokale Umgebung fehlerfrei konfiguriert ist:

```bash
git --version
docker --version
docker compose version
node --version
python3 --version
```

Wenn einer der Befehle fehlschlägt, repariere bitte zuerst die entsprechende Installation, bevor du fortfährst.

---

## 🛡️ 7. Sicherheits-Minimum (Security Guardrails)

*   **Keine Commits von Secrets:** Die Datei `.env` darf niemals in Git eingecheckt werden (sie ist bereits in der `.gitignore` registriert).
*   **Keine Keys teilen:** Teile deine API-Keys niemals in Prompts, Commits oder Screenshots.
*   **Free-Tier bevorzugen:** Nutze für den Workshop nach Möglichkeit nur Free-Tier-Zugänge oder eng begrenzte Test-Guthaben.
*   **Key-Rotation:** Falls du den Verdacht hast, dass ein Key offengelegt wurde, lösche oder rotiere ihn sofort im Dashboard des jeweiligen Providers.

---

## 🧭 Nächster Schritt

Wähle deinen passenden Lernpfad, um mit dem Workshop zu starten:
→ [Lernpfade wählen](learning-paths.md)