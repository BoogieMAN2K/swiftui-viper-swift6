# SwiftUI VIPER (Swift 6)

A SwiftUI-first, Swift 6–compliant specification of the VIPER architecture.

This repository defines a **strict architectural contract** and the
tooling foundations required to enforce it in large, long-lived SwiftUI
applications.

This is not a framework.
This is not a demo app.
This is not a flexible architecture guide.

---

## What This Repository Is

- A **normative specification** (`SKILL.md`)
- A **canonical SwiftUI VIPER module structure**
- A **source of truth** for architecture enforcement
- A foundation for templates, tooling, and automation

If there is a conflict between examples, templates, and documentation,
**the specification wins**.

---

## What This Repository Is Not

- A Swift Package or library
- A UIKit-based VIPER implementation
- An MVVM variant
- A teaching resource for SwiftUI basics
- A playground for architectural experimentation

If you are looking for flexibility, this repository is not for you.

---

## Target Audience

This repository is intended for:

- Senior Swift / iOS engineers
- Teams building multi-feature SwiftUI applications
- Codebases that must survive years of change
- Environments where architectural drift is costly

It intentionally assumes familiarity with SwiftUI, concurrency, and testing.

---

## Architectural Authority

The authoritative document is:

- `SKILL.md`

Anything that contradicts it is incorrect, even if it compiles.

Templates, examples, and tools exist to **serve the specification**, not
to redefine it.

---

## Non-Goals

- Backwards compatibility with UIKit
- Support for Combine-based state
- Multiple architectural variants
- Configuration-heavy abstractions

These are intentional exclusions.

---

## Status

- Specification: Stable
- Templates: In progress
- Examples: Planned
- Tooling: Planned
