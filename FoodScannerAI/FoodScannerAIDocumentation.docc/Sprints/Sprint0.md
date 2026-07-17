# Sprint 0 — Foundation & Architecture

## Overview

Sprint 0 established the professional foundation of FoodScannerAI.

The objective was not to build machine learning functionality yet, but to design an architecture capable of supporting:

* Core ML inference
* Vision image analysis
* Camera capture
* Nutrition services
* SwiftData persistence
* Future App Store scale features

> The guiding principle:
> 
> Build the architecture around the problem domain first, then introduce technology.

---

## Initial Architecture Created

The project initially followed a Clean Architecture, layer-based approach.

```
FoodScannerAI
├── App
│
├── Core
│   ├── DI
│   ├── Errors
│   ├── Extensions
│   └── Utilities
│
├── Domain
│   ├── Models
│   ├── Repositories
│   ├── Services
│   └── UseCases
│
├── Data
│   ├── Local
│   ├── ML
│   ├── Remote
│   └── Repositories
│
├── Features
│
└── Documentation
```

This created a separation between:

* Business rules
* Data implementations
* Infrastructure
* UI features

---

### Domain Design

The Domain layer represented the business language of the application.

It did not know about:

* SwiftUI
* UIKit
* Vision
* Core ML
* Networking
* SwiftData

---

### Food

Represents a recognized food item.

Examples:

* Banana
* Pizza
* Rice
* Chicken

---

### Nutrition

Represents nutritional information.

Separated from Food because nutrition depends on:

* Portion size
* Serving size
* Preparation method

---

### FoodPrediction

Represents a machine learning prediction.

Example:

```
Food:
Banana
Confidence:
95%
```

A prediction is not the same as a confirmed food item.

The ML model produces predictions; application logic decides how to use them.

---

### Repository Pattern

Created:

```swift
FoodRecognitionRepository
```

Purpose:

Define what the application needs without defining how it happens.

The Domain says:

“I need something that can recognize food.”

The Data layer decides the implementation:

* Core ML
* Remote API
* Mock implementation

---

### Service Layer

Created:

```swift
ImageProcessingService
```

Purpose:

Represent operations that transform data.

Examples:

* Resize image
* Convert image format
* Prepare image for ML inference

---

## Repository vs Service

### Repository

> Answers:
> 
> Where does data or capability come from?

Examples:

* Database
* API
* ML prediction

---

### Service

> Answers:
> 
> What operation needs to happen?

Examples:

* Image processing
* Validation
* Calculations

---

## Dependency Injection

Created:

```
Core
└── DI
└── DependencyContainer
```

The DependencyContainer became the composition root.

Future flow:

```
FoodScannerAIApp
↓
DependencyContainer
↓
ScannerViewModel
↓
RecognizeFoodUseCase
↓
FoodRecognitionRepository
↓
Core ML Implementation
```

---

## Swift 6 Concurrency Lessons

### MainActor Default Isolation

The project uses:

```
Default Actor Isolation: MainActor
```

Reason:

Application code commonly interacts with:

* Views
* ViewModels
* UI state

---

### Nonisolated Models

Domain values should not accidentally become UI-bound.

Example:

```swift
FoodPrediction
```

can move between:

```swift
Background Task
↓
FoodPrediction
↓
MainActor ViewModel
```

Therefore value types use:

```swift
nonisolated
Sendable
```

where appropriate.

---

### Actor Exploration

Swift actors were explored after Swift 6 reported mutable state problems in:

```swift
MockFoodRecognitionRepository
```

The issue:

```swift
var result
```

could be modified by multiple tasks.

Actors protect mutable state by guaranteeing serialized access.

Concept:

```
Task A
|
↓
Actor
|
↓
State mutation

Task B waits
```

---

## Protocol-Oriented Programming

The project was designed around capabilities instead of concrete implementations.

Instead of:

```
ViewModel
    |
    ↓
Concrete Class
```

we use:

```
ViewModel
    |
    ↓
Protocol
    |
    ↓
Any Implementation
```

Benefits:

* Testing
* Dependency Injection
* Flexibility
* Easier replacement

---

## First Test Created

Test:

```swift
recognizeFoodReturnsPrediction()
```

Flow:

```
Test
    ↓
RecognizeFoodUseCase
    ↓
MockFoodRecognitionRepository
    ↓
FoodPrediction
```

No:

* Camera
* Vision
* Core ML

were required.

---

## Sprint 0 Outcome

Completed:

* Project foundation
* Domain models
* Repository contracts
* Service contracts
* Use case layer
* Dependency injection foundation
* Swift concurrency decisions
* First Swift Testing test

---

Architecture Evolution

Later, the project evolved from a layer-based architecture into a feature-based architecture.

The principles remained the same:

* Separation of concerns
* Dependency inversion
* Testability
* Clear ownership

The final architecture became:

```
App
Core
Features
Shared
```

with Clean Architecture applied inside features.

## Git History

```
main
|
└── feat/project-foundation
        |
        ├── feat: create project foundation
        ├── feat: add food domain models
        ├── feat: add food recognition repository contract
        ├── feat: add image processing service contract
        ├── feat: add dependency container foundation
        ├── feat: add recognize food use case
        ├── test: add food recognition use case test
        └── feat: establish clean architecture foundation
```
