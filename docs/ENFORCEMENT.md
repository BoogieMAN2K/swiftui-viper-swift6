# Architecture Enforcement

## Purpose

This document defines how architectural integrity is preserved over time.

Enforcement favors mechanical constraints over conventions.

---

## Structural Enforcement

- Folder structure is authoritative
- File naming encodes architectural role
- Missing or extra files are violations

---

## Compile-Time Enforcement

- Final classes prevent inheritance-based drift
- Actor isolation enforces concurrency boundaries
- Observation is restricted to specific roles

---

## Review Contract

Human reviewers enforce intent, not structure.

If reviewers must check for missing roles or misplaced logic,
tooling or documentation is insufficient.

---

## Explicitly Forbidden Patterns

- Role merging
- Presenter instantiating Interactor
- Interactor importing SwiftUI
- View owning domain entities
- Example-only exceptions

Violations are architectural defects.
