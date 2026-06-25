# Swarm-Patterns

> Ziel: Verstehen, wann und wie mehrere Agenten zusammenarbeiten sollten.

## Warum Multi-Agent überhaupt?

Ein einzelner Agent ist gut für kleine, lineare Tasks.
Sobald Aufgaben parallelisierbar, risikobehaftet oder domanen-übergreifend sind, lohnt sich eine Aufteilung.

## Kernprinzip

- Zerlege die Arbeit in klare Rollen.
- Definiere Input/Output pro Rolle.
- Führe mit expliziten Übergabepunkten.
- Baue Guardrails und Reviews ein.

## Pattern 1: Planner -> Worker -> Reviewer

```mermaid
flowchart LR
    A[Planner] --> B[Worker]
    B --> C[Reviewer]
    C --> D{OK?}
    D -- Ja --> E[Merge/Ship]
    D -- Nein --> B
```

Wann nutzen:
- Feature-Entwicklung mit mittlerem Risiko
- Refactorings mit klaren Akzeptanzkriterien

## Pattern 2: Fan-Out / Fan-In

```mermaid
flowchart TD
    A[Coordinator] --> B[Worker A]
    A --> C[Worker B]
    A --> D[Worker C]
    B --> E[Aggregator]
    C --> E
    D --> E
    E --> F[Reviewer]
```

Wann nutzen:
- Parallele Analyse (Security, Performance, DX)
- Große Codebase mit mehreren Modulen

Risiko:
- Inkonsistente Stilentscheidungen zwischen Workern

## Pattern 3: Specialist Chain

```mermaid
flowchart LR
    A[Req Analyst] --> B[Implementer]
    B --> C[Test Engineer]
    C --> D[Security Reviewer]
    D --> E[Release Agent]
```

Wann nutzen:
- Produktionsnahe Pipelines
- Regulatorische oder sicherheitskritische Bereiche

## Pattern 4: Debate / Red Team

```mermaid
flowchart LR
    A[Builder Agent] --> C[Judge]
    B[Challenger Agent] --> C
    C --> D[Entscheidung + Nächster Schritt]
```

Wann nutzen:
- Architekturelle Entscheidungen
- Prompts/Policy-Design mit hohem Risiko

## Design-Checkliste

- Haben alle Agenten eine klare Rolle?
- Gibt es genau einen Owner für finale Entscheidung?
- Sind Schleifen begrenzt (max. Iterationen)?
- Sind Secrets und Schreibrechte minimal?
- Gibt es ein Audit-Log für kritische Aktionen?

## Minimales Rollen-Template

```yaml
name: reviewer
purpose: Qualität und Risiko vor dem Merge validieren
inputs:
  - patch
  - test_results
outputs:
  - decision
  - findings
limits:
  - kein direkter Push auf main
  - keine Secret-Lesezugriffe
```

## Typische Anti-Patterns

- Zu viele Agenten für kleine Aufgaben
- Undefinierte Verantwortung ("alle machen alles")
- Kein gemeinsames Artefakt-Format
- Reviewer ohne echten Stop-Mechanismus

## Weiter navigieren

- **Weiter zur Umsetzung:** [Orchestrierungs-Frameworks](orchestration-frameworks.md)
- **Risiken verstehen:** [Failure Modes](failure-modes.md)
