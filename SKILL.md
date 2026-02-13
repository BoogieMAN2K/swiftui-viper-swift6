---

name: viper-architecture-swiftui-swift6
description: Use when architecting complex SwiftUI applications targeting Swift 6 with strict concurrency, long-term maintenance requirements, and high testability needs. Encodes a SwiftUI-first, UIKit-free, concurrency-safe interpretation of VIPER.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# VIPER Architecture (SwiftUI + Swift 6)

## Purpose

This document defines a **SwiftUI-native, Swift 6–compliant** interpretation of VIPER. It deliberately **rejects UIKit-era assumptions** and encodes rules that are compatible with:

* Swift 6 language mode
* Strict concurrency checking
* SwiftUI declarative rendering
* Observation (`@Observable`)
* Actor-based isolation

This is not "classic Rambler VIPER". It is a principled evolution that preserves VIPER’s separation guarantees under modern Swift constraints.

---

## Core Principles (Unchanged)

* Single Responsibility per component
* Explicit data flow
* Testability by construction
* No business logic in UI
* No navigation logic in UI

---

## SwiftUI-Specific Constraints

SwiftUI introduces the following non-negotiable realities:

* Views are ephemeral `struct`s
* View identity is not stable
* UI updates must occur on the Main Actor
* Navigation is state-driven, not imperative

VIPER roles must adapt accordingly.

---

## Components and Responsibilities (Swift 6)

### View

**Form**: `struct` conforming to `View`

**Responsibilities**:

* Render state
* Emit user intent

**Must NOT**:

* Own business state
* Format domain data
* Perform navigation
* Contain logic beyond trivial view concerns

**Rules**:

* No `@StateObject` or `@ObservedObject` for business state
* No Combine usage
* Reads state from an `@Observable` Presenter

---

### Presenter

**Form**: `@MainActor @Observable final class`

**Responsibilities**:

* Own view state
* Translate interactor output into display-ready state
* Orchestrate user intents

**Must NOT**:

* Perform business logic
* Access persistence or networking directly
* Mutate UI from background threads

**Rules**:

* Single source of truth for view state
* UI-facing mutations occur on Main Actor
* May launch `Task`s but does not own concurrency policy

---

### Interactor

**Form**: `actor` or explicitly concurrency-safe type

**Responsibilities**:

* Execute use cases
* Apply business rules
* Coordinate domain services

**Must NOT**:

* Import SwiftUI
* Mutate UI state directly
* Perform navigation

**Rules**:

* Exposes async APIs
* Communicates results back to Presenter explicitly
* Conforms to `Sendable` contracts

---

### Entity

**Form**: Plain Swift types (`struct`, `enum`)

**Responsibilities**:

* Represent domain data

**Must NOT**:

* Contain behavior
* Know about UI or persistence

**Rules**:

* Must conform to `Sendable`

---

### Router

**Form**: `@MainActor @Observable final class`

**Responsibilities**:

* Represent navigation state
* Act as a state machine for routing

**Must NOT**:

* Perform business logic
* Render views

**Rules**:

* Exposes routes as enums
* Navigation is driven by state binding
* No imperative navigation calls

---

## Canonical SwiftUI VIPER Module Layout

```text
Feature/
├── FeatureView.swift
├── FeaturePresenter.swift
├── FeatureInteractor.swift
├── FeatureRouter.swift
├── FeatureEntity.swift
├── FeatureViewState.swift
├── FeatureContracts.swift
└── FeatureModule.swift
```

This structure is mandatory. Automation and review assume this layout.

---

## Canonical Data Flow

```
User Action
 → View
 → Presenter
 → Interactor
 → Entity / Services
 → Interactor
 → Presenter (MainActor)
 → View State
 → View Render
```

**Critical Rule**: Entities never reach the View directly.

---

## Navigation Model (SwiftUI)

* Router exposes `route: FeatureRoute?`
* View or Module binds navigation to router state
* Presenter mutates router state

Navigation is declarative and reversible.

---

## Module Composition

Each feature exposes a single build entry point.

Responsibilities:

* Instantiate and wire all VIPER components
* Resolve circular dependencies explicitly
* Apply environment injection if required

Module composition is the only place where construction occurs.

---

## Concurrency Rules (Swift 6)

Mandatory:

* Presenter and Router are `@MainActor`
* Interactor is `actor` or thread-safe
* Entities are `Sendable`
* No UI mutation outside Main Actor

Forbidden:

* Implicit thread hopping
* Background mutation of observable state

---

## Testing Strategy

Recommended order:

1. Interactor (business logic, async, no UI)
2. Presenter (state transformation)
3. View (snapshot or minimal rendering tests)

Each layer is testable in isolation.

---

## Anti-Patterns (SwiftUI Edition)

| Anti-Pattern                 | Why It Is Invalid           |
| ---------------------------- | --------------------------- |
| Presenter conforms to `View` | Collapses responsibilities  |
| Using `ObservableObject`     | Obsolete under Swift 6      |
| Combine for state            | Unnecessary and error-prone |
| Business logic in Presenter  | Violates VIPER              |
| Imperative navigation        | Breaks SwiftUI model        |
| View owns domain state       | Breaks testability          |

---

## Acceptance Checklist (Hard Rules)

A feature is NOT valid VIPER if:

* Presenter is not `@MainActor`
* Interactor is not concurrency-safe
* View owns business state
* Router performs logic
* Entities reach the View
* Navigation is not state-driven

---

## Intended Use

Use this architecture for:

* Multi-feature SwiftUI apps
* Long-lived codebases
* Teams larger than 2 engineers
* Projects requiring strong test isolation

Avoid for:

* Prototypes
* Single-screen utilities
* Short-lived experiments

---

## End-to-End Example: Weather Feature

This example demonstrates a complete, valid SwiftUI VIPER module that complies with all rules in this document.

### ViewState

```swift
struct WeatherViewState: Sendable {
    var temperatureText: String = "--"
    var isLoading: Bool = false
}
```

### View

```swift
struct WeatherView: View {
    let presenter: WeatherPresenter

    var body: some View {
        VStack {
            if presenter.state.isLoading {
                ProgressView()
            } else {
                Text(presenter.state.temperatureText)
            }
        }
        .onAppear { presenter.onAppear() }
    }
}
```

### Presenter

```swift
@MainActor
@Observable
final class WeatherPresenter {
    var state = WeatherViewState()

    private let interactor: WeatherInteractorInput
    private let router: WeatherRouter

    init(interactor: WeatherInteractorInput, router: WeatherRouter) {
        self.interactor = interactor
        self.router = router
    }

    func onAppear() {
        state.isLoading = true
        Task { await interactor.loadWeather() }
    }

    func didLoadWeather(_ data: WeatherData) {
        state.isLoading = false
        state.temperatureText = "\(data.temperature)°"
    }
}
```

### Interactor

```swift
protocol WeatherInteractorInput: Sendable {
    func loadWeather() async
}

actor WeatherInteractor: WeatherInteractorInput {
    private let service: WeatherService
    private let presenter: WeatherPresenter

    init(service: WeatherService, presenter: WeatherPresenter) {
        self.service = service
        self.presenter = presenter
    }

    func loadWeather() async {
        let data = await service.fetch()
        await presenter.didLoadWeather(data)
    }
}
```

### Router

```swift
@MainActor
@Observable
final class WeatherRouter {
    var route: WeatherRoute?
}

enum WeatherRoute: Sendable {
    case details
}
```

### Module Composition

```swift
struct WeatherModule {
    @MainActor
    static func build() -> some View {
        let router = WeatherRouter()
        let presenter = WeatherPresenter(
            interactor: DummyWeatherInteractor(),
            router: router
        )

        let service = WeatherService()
        let interactor = WeatherInteractor(
            service: service,
            presenter: presenter
        )

        presenter.setInteractor(interactor)

        return WeatherView(presenter: presenter)
            .environment(router)
    }
}
```

---

## Migration Guide: MVC / MVVM to SwiftUI VIPER

### From MVC (UIKit)

**Symptoms**:

* Massive ViewController
* Networking and formatting mixed
* Hard-to-test UI logic

**Migration Steps**:

1. Extract domain logic into an Interactor actor
2. Convert ViewController into SwiftUI View
3. Move formatting into Presenter
4. Replace imperative navigation with Router state

### From MVVM (SwiftUI)

**Symptoms**:

* ViewModel owns navigation
* ViewModel mixes business logic
* Difficult to test navigation flows

**Migration Steps**:

1. Split ViewModel into Presenter + Interactor
2. Move navigation state into Router
3. Convert mutable model state into ViewState
4. Make Interactor async and Sendable

---

## Automation and Rejection Rules

A generator, template, or AI skill MUST reject generation if:

* Presenter is missing `@MainActor`
* Presenter or Router are not `@Observable`
* Interactor is not an `actor` or thread-safe
* View uses `@StateObject` or `@ObservedObject` for business state
* Combine is imported
* Navigation is triggered imperatively
* Entities are not `Sendable`

These rules are hard constraints, not guidelines.

---

## Design Goal

The goal is not ceremony.

The goal is **predictability under change** in a Swift 6, SwiftUI-first world.
