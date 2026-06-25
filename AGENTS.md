# Repository-Instruktionen

- Git Bash für Shell-basierte Tools bevorzugen, wenn es der Aufgabe hilft.
- Änderungen fokussiert halten und unnötige externe Referenzen vermeiden, wenn sie nicht angefordert sind.
- Sämtliche Inhalte für Labs müssen in deutscher Sprache gehalten werden. Etablierte Fachbegriffe wie agentic programming, workflow, prompt oder MCP dürfen bestehen bleiben, aber erklärender Inhalt und Aufgabenstellungen bleiben auf Deutsch.
- Bei Agent-Vergleichen klar zwischen Coding Agent, Agent Orchestrator (z. B. Devin Desktop) und Multi-Agent-Framework (z. B. LangGraph, CrewAI, AutoGen) unterscheiden.
- Wenn Ordner oder Dateien im Repository geändert werden, muss der Abschnitt "Repository-Struktur: Die 8 Module" in README.md geprüft und bei Bedarf aktualisiert werden, damit Struktur und Darstellung konsistent bleiben.
- Um zu prüfen, ob du in einem Devcontainer läufst: Die Umgebungsvariable `RUNNING_IN_DEVCONTAINER=true` ist gesetzt
- Wenn du eine Anwendung im Devcontainer verfügbar machen willst, nutze einen der bereits weitergeleiteten Ports aus `.devcontainer/devcontainer.json`. Für einen neuen Port: `forwardPorts` in devcontainer.json erweitern und einen freien Port wählen.