# Repository Invariants

The following invariants are intentional and non-negotiable.

## Architectural

- SwiftUI only
- Swift 6 language mode
- Strict concurrency required
- VIPER roles as defined in SKILL.md
- One canonical module structure

## Technical

- No UIKit imports
- No Combine usage
- Presenter and Router are MainActor-isolated
- Interactors are concurrency-safe
- Entities are Sendable

## Organizational

- Specification changes require justification
- Templates must match the specification
- Examples may not extend the architecture
- Tooling enforces, never redefines
