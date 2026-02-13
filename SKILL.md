# SKILL.md

## Purpose

This document defines the **binding contract** for any AI skill, agent, or code generator operating in this repository.

The skill is a **constrained generator**, not an assistant or refactoring tool.

> Architecture is authoritative. The skill operates strictly within it.

---

## Architectural Authority

The following repository files are authoritative and immutable for the skill:

* /ARCHITECTURE.md
* /TEMPLATE.md
* /GOLDEN_PATH.md
* /ENFORCEMENT.md
* /INVARIANTS.md
* /CONTRIBUTING.md

If generated output conflicts with any of the above, the output is invalid.

The skill must never propose architectural changes, alternatives, optimizations, or simplifications.

---

## Mandatory Pre-Read Requirement

Before generating any output, the skill **must**:

1. Read this file (`SKILL.md`)
2. Read all authoritative files listed above
3. Treat their contents as hard constraints

Failure to do so invalidates the output.

---

## Skill Scope

### Allowed Capabilities

The skill may:

* Generate a new SwiftUI VIPER feature module using the official template
* Apply a module name consistently across all files and types
* Populate role skeletons with minimal placeholder logic
* Generate simple async flows inside the Interactor
* Add ViewState properties required by the View
* Add Presenter formatting logic
* Resolve Presenter–Interactor cycles using the established attachment pattern in the Module.

### Forbidden Capabilities

The skill must not:

* Add, remove, or merge VIPER roles
* Introduce new abstractions or layers
* Introduce helpers outside defined roles
* Modify template structure or file layout
* Use UIKit or UIKit-derived concepts
* Use `@State`, `@StateObject`, `@ObservedObject`, or `@EnvironmentObject`
* Introduce third-party libraries
* Introduce dependency injection frameworks
* Refactor, optimize, or reinterpret the architecture

If a request cannot be satisfied within these constraints, the skill must fail explicitly.

---

## Inputs

### Required Inputs

* **Module name**

  * PascalCase
  * Used verbatim for folder name, file names, and type names

* **Feature intent**

  * 1–2 sentences describing the responsibility of the feature

### Optional Inputs

* Initial view fields
* Async use cases
* Navigation intents

No other inputs are permitted.

---

## Outputs

The skill must produce **exactly one feature module folder** containing **only** the following files:

* `<Module>View.swift`
* `<Module>Presenter.swift`
* `<Module>Interactor.swift`
* `<Module>Router.swift`
* `<Module>Entity.swift`
* `<Module>ViewState.swift`
* `<Module>Contracts.swift`
* `<Module>Module.swift`

Rules:

* No additional files
* No missing files
* File names must match role names exactly
* Folder name must match the module name

---

## Generation Rules

Generated code must:

* Compile under Swift 6
* Use SwiftUI and Observation
* Match the official template exactly in structure
* Conform to all invariants and enforcement rules
* Contain only minimal placeholder logic

Generated code must not:

* Perform real networking or persistence
* Reference other feature modules by default
* Contain example-only exceptions

---

## Canonical Prompt (Authoritative)

All AI integrations must use the following prompt **verbatim**:

```
Before generating any output:
- Read SKILL.md
- Read all authoritative files listed in SKILL.md
- Treat them as immutable constraints

You are generating a SwiftUI VIPER feature module.

Architecture rules:
- SwiftUI only, no UIKit
- Swift 6
- Use Observation, not property wrappers
- Exactly one View, Presenter, Interactor, Router, Entity, ViewState, Contracts, Module
- No role merging
- No new abstractions
- No exceptions for examples

The generated module must:
- Match the template exactly
- Use the provided module name consistently
- Contain minimal placeholder logic
- Compile without modification

If a requirement cannot be satisfied within these rules, output is invalid.
```

This prompt is a **contract**, not a guideline.

---

## Validation

AI-generated output is subject to the same validation as human-written code:

* Folder structure verification
* Required file presence
* Forbidden import checks
* Successful compilation

If validation fails:

* The output is rejected
* The architecture is not modified

Rules must never be relaxed to accommodate AI output.

---

## Versioning

The skill operates against a specific architecture version.

Example:

```
SwiftUI VIPER Architecture v1.0
```

Any architectural change requires:

* A new version identifier
* Updated authoritative documents
* Explicit opt-in to regeneration

---

## Non-Goals

The skill is explicitly not responsible for:

* Teaching architecture
* Making design decisions
* Reducing boilerplate
* Optimizing code
* Enforcing runtime behavior

Its sole responsibility is **correct, repeatable generation**.

---

## Final Rule

If the skill ever produces output that requires architectural explanation or justification, the skill has failed.

Architecture remains human-owned.
