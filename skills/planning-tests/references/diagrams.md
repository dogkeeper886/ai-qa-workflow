# Test Diagrams Reference

## When to Generate Diagrams

| Scenario Count | Diagrams to Generate |
|----------------|---------------------|
| 1-3 scenarios | Coverage Matrix only |
| 4 scenarios | Coverage Matrix + one flow diagram |
| 5+ scenarios | All diagram types |

---

## Configuration Flow Diagram

For UI-centric features, show the user journey:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         FEATURE CONFIGURATION FLOW                          │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌─────────────────┐
                              │  Entry Point    │
                              └────────┬────────┘
                                       │
                                       ▼
                    ┌──────────────────────────────────────┐
                    │         Decision Point               │
                    └──────────────────┬───────────────────┘
                                       │
         ┌─────────────────────────────┼─────────────────────────────┐
         ▼                             ▼                             ▼
    ┌─────────┐                  ┌─────────┐                  ┌─────────┐
    │Option A │                  │Option B │                  │Option C │
    └────┬────┘                  └────┬────┘                  └────┬────┘
         │                            │                            │
         └────────────────────────────┼────────────────────────────┘
                                      │
                                      ▼
                         ┌───────────────────────┐
                         │   Configuration       │
                         │   Applied             │
                         └───────────────────────┘
```

---

## Data Flow Diagram

For integration features, show data paths:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DATA FLOW PATHS                                   │
└─────────────────────────────────────────────────────────────────────────────┘

    ┌──────────┐                                           ┌──────────────┐
    │  Source  │                                           │   Target     │
    └────┬─────┘                                           └──────▲───────┘
         │                                                        │
         │ Protocol/Format                                        │
         ▼                                                        │
    ┌──────────┐         ┌─────────────────────────────────┐     │
    │ Process  │────────►│     Data Transformation         │─────┘
    └──────────┘         └─────────────────────────────────┘

                    ════════════════════════════════════════
                              MULTIPLE MODES
                    ════════════════════════════════════════

    MODE 1: Direct                        MODE 2: Proxy
    ─────────────────                     ─────────────────

    ┌────────┐     ┌──────────┐          ┌────────┐     ┌────────┐     ┌──────────┐
    │ Source │────►│  Target  │          │ Source │────►│  Proxy │────►│  Target  │
    └────────┘     └──────────┘          └────────┘     └────────┘     └──────────┘
```

---

## Modular Test Design Diagram

For complex test suites, show organization:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MODULAR TEST SCENARIO DESIGN                             │
│              (Each module tests one variable/aspect)                        │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌───────────────────┐
                              │   CORE FEATURE    │
                              │     TS-01         │
                              │  Basic Config &   │
                              │  Functionality    │
                              └─────────┬─────────┘
                                        │
        ┌───────────────────────────────┼───────────────────────────────┐
        │                               │                               │
        ▼                               ▼                               ▼
┌───────────────────┐         ┌───────────────────┐         ┌───────────────────┐
│   INTEGRATION     │         │   COMPATIBILITY   │         │   CONTROL         │
├───────────────────┤         ├───────────────────┤         ├───────────────────┤
│  TS-02: [Name]    │         │  TS-04: [Name]    │         │  TS-06: [Name]    │
│  - Detail 1       │         │  - Detail 1       │         │  - Detail 1       │
│  TS-03: [Name]    │         │  TS-05: [Name]    │         │                   │
└───────────────────┘         └───────────────────┘         └───────────────────┘
```

---

## Coverage Matrix

Always include a coverage matrix:

```
┌────────────────────┬───────┬───────┬───────┬───────┬───────┬───────┐
│ Test Aspect        │ TS-01 │ TS-02 │ TS-03 │ TS-04 │ TS-05 │ TS-06 │
├────────────────────┼───────┼───────┼───────┼───────┼───────┼───────┤
│ UI Configuration   │   ✓   │       │       │       │   ✓   │       │
│ API Configuration  │       │       │   ✓   │       │       │       │
│ Data Flow Direct   │   ✓   │   ✓   │       │   ✓   │   ✓   │       │
│ Data Flow Proxy    │       │       │       │       │       │   ✓   │
│ Backward Compat    │       │   ✓   │       │       │       │       │
│ Error Handling     │       │       │       │       │       │   ✓   │
│ Feature Flag       │       │       │       │       │       │   ✓   │
│ Client Validation  │   ✓   │       │       │       │       │       │
└────────────────────┴───────┴───────┴───────┴───────┴───────┴───────┘
```

---

## Tips for Good Diagrams

1. **Keep boxes aligned** - Use consistent spacing
2. **Use clear labels** - Short but descriptive
3. **Show relationships** - Arrows indicate flow/dependency
4. **Highlight the new** - Mark new features with ◄── NEW
5. **Group related items** - Use visual clustering
