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
> Build the architecture around the problem domain first, then introduce > technology.

---

## Architecture Created

The project structure:

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
│   ├── Camera
│   ├── Scanner
│   ├── Meals
│   └── Dashboard
│
└── Documentation
```

---

## Domain Design

The Domain layer represents the business language of the application.

It does not know about:

* SwiftUI
* UIKit
* Vision
* Core ML
* Networking
* SwiftData

---

### Food

Represents a recognized food item.

Example:

Banana
Pizza
Rice
Chicken

---

### Nutrition

Represents nutritional information.

Separated from Food because the same food can have different nutrition values depending on:

* portion size
* preparation method
* serving size

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

Important distinction:

A prediction is not the same as a confirmed food item.

The ML model produces predictions; the application decides what to do with them.

---

## Repository Pattern

Created:

```swift
FoodRecognitionRepository
```

Purpose:

Define what the application needs without defining how it happens.

The Domain says:

“**I need something that can recognize food.**”

The Data layer later decides:

* Core ML implementation
* Remote API implementation
* Mock implementation

---

## Service Layer

Created:

```swift
ImageProcessingService
```

Purpose:

Represent operations that transform data.

Examples:

* Resize image
* Normalize image
* Convert image format
* Prepare image for ML inference

---

## Repository vs Service

A key concept learned during Sprint 0:

### Repository

> Answers:
> 
> Where does data come from?

Examples:

* Database
* API
* ML model output

---

### Service

> Answers:
>
> What operation needs to be performed?

Examples:

* Image processing
* Validation
* Calculations

---

### Dependency Injection

Created:

```
Core
└── DI
└── DependencyContainer
```

The DependencyContainer will become the composition root.

Its responsibility:

Create and connect objects.

Example future flow:

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
CoreMLFoodRecognitionRepository
```

---

## Swift 6 Concurrency Lessons

### MainActor Default Isolation

The project uses:

```
Default Actor Isolation: MainActor
```

Reason:

Most application code interacts with UI:

* Views
* ViewModels
* UI state

---

### Domain Models and nonisolated

A key discovery:

Domain models should not accidentally become UI-bound.

Example:

```swift
FoodPrediction
```

is not UI state.

It is a value that can move between:

```
Background Task
↓
FoodPrediction
↓
MainActor ViewModel
```

Therefore:

```swift
nonisolated + Sendable
```

was used.

---

### Actor Exploration

We explored Swift actors after creating:

```swift
MockFoodRecognitionRepository
```

Swift 6 warned about mutable state inside a Sendable class.

The problem:

```swift
var result
```

could be changed simultaneously by multiple tasks.

The solution:

Use an actor.

Actors protect mutable state by ensuring access happens sequentially.

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

This prevents data races.

---

## Protocol-Oriented Programming Lessons

The key principle:

Do not design around concrete objects.

Instead design around capabilities.

Instead of:

```
ScannerViewModel
|
↓
CoreMLClassifier
```

we designed:

```
ScannerViewModel
|
↓
Protocol
|
↓
Any implementation
```

Benefits:

* Testing
* Flexibility
* Dependency Injection
* Easier replacement of implementations

---

## First Test Created

Test:

```
recognizeFoodReturnsPrediction
```

Purpose:

Verify architecture before Core ML exists.

Flow tested:

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

needed.

---

## Sprint 0 Outcome

Completed:

- [x] Project architecture
- [x] Domain layer
- [x] Repository contract
- [x] Service contract
- [x] Use case layer
- [x] Dependency injection foundation
- [x] Swift concurrency decisions
- [x] First Swift Testing test

The application now has a professional foundation.

---

## Git History

Sprint 0 commit flow:

```
main
|
|
└── feat/project-foundation
        |
        |
        ├── feat: create project foundation
        |
        ├── feat: add food domain models
        |
        ├── feat: add food recognition repository contract
        |
        ├── feat: add image processing service contract
        |
        ├── feat: add dependency container foundation
        |
        ├── feat: add recognize food use case
        |
        ├── test: add food recognition use case test
        |
        └── feat: establish clean architecture foundation for FoodScannerAI
                |
                |
                PR
                |
                ↓
            develop
```

---

## Next Sprint

### Sprint 1 — Image Pipeline

Goal:

Teach the iPhone to see.

Pipeline:

```
Camera
↓
Image Data
↓
Image Processing
↓
Vision
↓
Core ML
↓
Food Prediction
```

Technologies introduced:

* AVFoundation
* Vision
* Core ML image handling
* Image preprocessing
* ML inference pipeline
