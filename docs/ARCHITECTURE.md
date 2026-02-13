# SwiftUI VIPER Architecture

## Purpose

This repository defines a strict implementation of the VIPER architecture
for SwiftUI applications using Swift 6 and Observation.

The goal is predictability, mechanical reasoning, and long-term maintainability,
not convenience or minimal file count.

---

## Architectural Principles

- One feature equals one module
- Each module contains exactly one View, Presenter, Interactor, Router, Entity, and ViewState
- Responsibilities are explicit and non-overlapping
- Dependencies are unidirectional and enforced
- SwiftUI is treated as a rendering layer, not an architecture

---

## Role Definitions

### View
- Renders state provided by the Presenter
- Forwards user and lifecycle events
- Contains no business logic
- Does not own state

### Presenter
- Owns ViewState
- Translates domain data into renderable values
- Coordinates between View, Interactor, and Router
- Never performs async work

### Interactor
- Owns business logic
- Performs async work
- Isolated from UI concerns
- Communicates via protocols only

### Router
- Owns navigation intent state
- Does not perform navigation
- Exposes intent, not destinations

### Entity
- Pure domain model
- No UI or persistence concerns
- No behavior

### ViewState
- Pure render state
- Owned exclusively by the Presenter
- Contains no logic

---

## Non-Goals

This architecture explicitly does not aim to:

- Minimize boilerplate
- Replace SwiftUI patterns
- Support multiple architectural styles
- Optimize for rapid prototyping

---

## Authority

If code or examples in this repository contradict this document,
the contradiction is a defect and must be resolved explicitly.
