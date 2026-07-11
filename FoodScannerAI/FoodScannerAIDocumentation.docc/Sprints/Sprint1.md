
# Sprint 1 — Image Processing Foundation

Build the image-processing layer.

## Goal

Build the image-processing layer required before integrating Vision and Core ML.

Rather than jumping directly into machine learning, this sprint focused on understanding how image data moves through Apple's frameworks.

---

## What We Built

## ImageConversionService

Created a protocol representing image conversion.

Responsibilities:

- Accept raw image data.
- Produce a CGImage.
- Hide ImageIO implementation details.

This follows Protocol-Oriented Programming and Dependency Injection principles.

---

## CGImageConverter

Implemented ImageConversionService using ImageIO.

Pipeline:

```
Data

↓

CGImageSource

↓

CGImage
```

The converter is infrastructure and therefore marked:

nonisolated

instead of @MainActor.

---

## ImageConversionError

Added domain-specific errors for conversion failures.

Rather than exposing ImageIO errors directly, the converter throws application-level errors.

---

## TestImageFactory

Created an in-memory PNG generator.

Advantages:

- No bundled test assets.
- Fast.
- Deterministic.
- Repeatable.
- Suitable for CI.

---

## VisionFoodRecognitionService

Created the first Vision integration skeleton.

Current pipeline:

```
Image Data

↓

ImageConversionService

↓

CGImage

↓

VNImageRequestHandler

↓

TODO: VNCoreMLRequest

↓

TODO: FoodPrediction
```

The service intentionally stops before connecting Core ML because no model exists yet.

---

## Architecture Decisions

## ImageConversionService

Chosen because image conversion is an independent responsibility.

Future implementations could convert using different image representations while the rest of the application remains unchanged.

---

## Dependency Injection

VisionFoodRecognitionService depends upon:

- any ImageConversionService

instead of:

- CGImageConverter

This keeps the service testable and replaceable.

---

## Swift 6 Actor Isolation

Project default actor isolation:

MainActor

Infrastructure components opted out using:

nonisolated

Examples:

- FoodPrediction
- CGImageConverter
- VisionFoodRecognitionService

Reason:

Image processing performs CPU work and owns no UI state.

---

## Testing

Implemented tests for:

✓ PNG conversion succeeds

✓ Invalid image data throws appropriate error

---

## Detours & Concepts Learned

## Services vs Repositories

**Repository**:

Provides application-facing access to capabilities or data.

**Service**:

Performs a specific operation.

Examples:

```
FoodRecognitionRepository

↓

VisionFoodRecognitionService

↓

ImageConversionService

↓

CGImageConverter
```

---

## Why Protocol-Oriented Programming?

Protocols define capabilities rather than implementations.

The application depends on abstractions instead of concrete types.

Benefits:

- Dependency Injection
- Easy testing
- Flexible implementations
- Decoupled architecture

---

## Why use `any`?

Modern Swift requires existential types to be explicit.

Example:

private let converter: any ImageConversionService

Meaning:

"Store any object conforming to this protocol."

---

## Why use `nonisolated`?

Default project isolation is MainActor.

Image conversion:

- owns no mutable UI state
- performs CPU work

Therefore it should not execute on MainActor.

---

## Understanding Actors

Actors protect mutable shared state.

Instead of multiple threads mutating the same object simultaneously:

```
Thread A

↓

Actor

↑

Thread B
```

Only one operation executes at a time.

Our infrastructure components do not own mutable shared state, so actors were unnecessary.

---

## Current Pipeline

```
Image Data

↓

CGImageConverter

↓

CGImage

↓

VNImageRequestHandler

↓

TODO: Core ML Model

↓

TODO: FoodPrediction
```

---

## Why Sprint 1 Stops Here

A VNCoreMLRequest requires a VNCoreMLModel.

That model comes from a compiled .mlmodel.

Since no model exists yet, completing the Vision request would be premature.

Sprint 2 introduces the Core ML model before finishing the Vision pipeline.

---

## Looking Ahead

Sprint 2

Core ML Model Integration

Goals:

- Understand .mlmodel files
- Load models safely
- Learn how Xcode generates Swift interfaces
- Create a model loader
- Connect Vision with Core ML

---

## Git History

```
main
│
├── Sprint 0
│   ├── feat: create clean architecture project structure
│   ├── feat: add domain models
│   ├── feat: add repository contracts
│   ├── feat: add dependency container
│   ├── feat: add recognize food use case
│   └── test: add recognize food use case tests
│
└── feat/image-processing-service
├── feat: add image conversion service protocol
├── feat: implement cgimage converter
├── test: add cgimage converter tests
├── test: add png image factory
└── feat: scaffold vision food recognition service
```
