# Sprint 1.5 — Feature-Based Architecture Refactor

## Goal

Refactor FoodScannerAI from a layer-based architecture into a feature-based architecture while preserving all functionality.

The objective was to improve scalability, discoverability, and alignment with professional iOS project structures.

---

## Why Refactor?

The original architecture separated code by technical layers:

```
Domain
Data
Features
```

Although this followed Clean Architecture principles, feature development required navigating multiple folders.

For example, Scanner functionality was spread across:

* Domain
* Data
* Feature UI

The refactor reorganized the project around business capabilities.

---

## New Architecture

Final structure:

```
FoodScannerAI
├── App
│
├── Core
│
├── Features
│   ├── Scanner
│   ├── Camera
│   ├── Meals
│   └── Dashboard
│
├── Shared
│
└── Resources
```

---

## Feature Structure

Each feature owns its business logic.

Example:

```
Features
└── Scanner
    ├── Presentation
    ├── Domain
    └── Data
```

---

### Scanner Feature

Final organization:

```
Scanner
├── Presentation
│   ├── Views
│   └── ViewModels
│
├── Domain
│   ├── Models
│   ├── Repositories
│   ├── Services
│   └── UseCases
│
└── Data
    └── VisionFoodRecognitionService
```

---

### Core Infrastructure

Reusable technology-specific code moved into Core.

Example:

```
Core
└── ML
    ├── Converters
    ├── ImageProcessing
    ├── Loaders
    └── Vision
```

Reason:

Core ML and Vision are infrastructure capabilities, not business rules.

---

### Dependency Direction

The architecture now follows:

```
Presentation
↓
Domain
↓
Data
↓
Core
```

Business logic remains independent from implementation details.

---

## Benefits

### Better Discoverability

A developer can understand a feature by opening one folder.

---

### Better Scalability

New capabilities can be added independently:

* Meal tracking
* Barcode scanning
* Nutrition dashboard
* History

----

### Better Team Development

Teams can work on separate features with fewer conflicts.

----

### Verification

Completed:

* Moved ML infrastructure into Core
* Organized Scanner feature layers
* Preserved Clean Architecture principles
* Build succeeds
* All tests pass

---

## Git History

```
main
|
└── refactor/feature-based-architecture
        |
        ├── refactor: migrate to feature-based architecture
        ├── refactor: move ML infrastructure into Core
        ├── refactor: organize Scanner feature layers
        └── test: verify architecture refactor
```

---

## Next Sprint

### Sprint 2 — Core ML Integration

#### Goals:

* Add a trained Core ML model
* Understand .mlmodel vs .mlmodelc
* Load models safely
* Connect Vision with Core ML
* Produce real ML predictions
