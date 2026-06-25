# Orchestrierungs-Frameworks

> Ziel: Das passende Orchestrierungsmodell je nach Teamgröße, Risiko und Task-Typ wählen.

## Entscheidungslogik

```mermaid
flowchart TD
    A[Start] --> B{Nur 1-2 Agenten?}
    B -- Ja --> C[Leichtgewichtiges Coordinator-Pattern]
    B -- Nein --> D{Strenge State Kontrolle nötig?}
    D -- Ja --> E[Graph-basierte Orchestrierung]
    D -- Nein --> F[Event/Queue basierte Orchestrierung]
```

## Option A: Leichtgewichtiger Coordinator

Beschreibung:
- Ein zentraler Agent delegiert Teilaufgaben.
- Schnell aufzusetzen, gut für Workshops und Pilotprojekte.

Stärken:
- Wenig Overhead
- Schnell iterierbar

Schwächen:
- Skaliert schlecht bei vielen parallelen Streams
- Coordinator kann Bottleneck werden

## Option B: Graph-basierte Orchestrierung

Beschreibung:
- Workflows als Knoten und Kanten mit explizitem Zustand.
- Deterministische Übergänge, gute Debuggability.

Stärken:
- Klarer Kontrollfluss
- Reproduzierbare Runs
- Saubere Retry/Fallback-Strategien

Schwächen:
- Höherer Modellierungsaufwand
- Mehr initialer Setup-Aufwand

## Option C: Event/Queue-basiert

Beschreibung:
- Agenten reagieren auf Events aus Queue/Bus.
- Entkoppelt, horizontal skalierbar.

Stärken:
- Hohe Parallelität
- Gute Teamentkopplung

Schwächen:
- Komplexeres Observability-Setup
- Idempotenz zwingend

## Referenzarchitektur

```mermaid
flowchart LR
    A[Issue/Event] --> B[Coordinator]
    B --> C[Planner Agent]
    C --> D[Worker Pool]
    D --> E[Reviewer Agent]
    E --> F[Policy Gate]
    F --> G[PR / Deploy]
```

## Governance-Ebene (muss immer da sein)

- Policy Gate vor Merge/Deploy
- Approval bei sensiblen Dateien
- Secret Scanning in jedem Lauf
- Rollback-Strategie für fehlerhafte Agent-Aktionen

## Metriken für Vergleich

| Metrik | Coordinator | Graph-basiert | Event/Queue |
|---|---|---|---|
| Setup-Zeit | Sehr niedrig | Mittel | Mittel-Hoch |
| Transparenz | Mittel | Hoch | Mittel |
| Skalierung | Niedrig-Mittel | Mittel-Hoch | Hoch |
| Governance | Mittel | Hoch | Hoch |
| Workshop-Fit | Sehr gut | Gut | Mittel |

## Praktische Empfehlung

- Workshop/POC: Coordinator-Pattern
- Team 5-20 mit Qualitätsanspruch: Graph-basiert
- Plattform/Enterprise: Event + Policy Gates + Observability

## Weiter navigieren

- **Zurück zu den Patterns:** [Swarm-Patterns](swarm-patterns.md)
- **Weiter zu Risiken und Gegenmaßnahmen:** [Failure Modes](failure-modes.md)
