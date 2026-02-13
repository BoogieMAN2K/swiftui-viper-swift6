# Feature Module Template

## Purpose

This document defines the **authoritative structure** of a feature module.

The template is an executable specification. Deviations are architectural
violations, not stylistic choices.

---

## Module Structure

Each feature module must contain exactly the following files:

- `<Module>View.swift`
- `<Module>Presenter.swift`
- `<Module>Interactor.swift`
- `<Module>Router.swift`
- `<Module>Entity.swift`
- `<Module>ViewState.swift`
- `<Module>Contracts.swift`
- `<Module>Module.swift`

No additional files are permitted.

---

## Dependency Rules

- The View depends only on the Presenter
- The Presenter depends on Interactor and Router abstractions
- The Interactor depends only on domain types and Presenter protocols
- The Router is independent
- No role instantiates another role

All wiring occurs in `<Module>Module.swift`.

---

## Concurrency Rules

- Presenters are `@MainActor`
- Interactors performing async work are `actor`s
- Views do not perform async work

---

## Observation Rules

- Only Presenters and Routers may be observable
- Entities and ViewState must not be observable

---

## Invariants

The template must compile under Swift 6 without modification.

If a feature cannot be expressed using this template,
the architecture must be revisited.

## Cyclic Dependency Resolution

Presenter–Interactor cycles are resolved during module composition using
an explicit attachment step.

- Presenters may be initialized without an Interactor
- Interactors may depend on a Presenter
- The attachment must occur only inside `<Module>Module.swift`
- No partially wired object may escape the Module
