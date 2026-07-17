# Sprint 1 — Image Processing Foundation

## Goal

Build the image-processing pipeline required before integrating Vision and Core ML.

The objective was to understand how image data moves through Apple’s frameworks before introducing a trained model.

---

## What We Built

ImageConversionService

Created:

```swift
protocol ImageConversionService
```

Responsibility:

* Accept raw image data
* Produce a CGImage
* Hide ImageIO implementation details

Pipeline:

```
Data
    ↓
CGImageSource
    ↓
CGImage
```

---

### CGImageConverter

Implemented:

```swift
CGImageConverter
```

using ImageIO.

Responsibilities:

* Convert image data
* Validate image input
* Throw application-level errors

Infrastructure components were marked:

```swift
nonisolated
```

because they do not manage UI state.

---

### ImageConversionError

Created application-level errors:

Instead of exposing ImageIO errors directly:

```swift
ImageIO Error
    ↓
Application Error
    ↓
ImageConversionError
```

---

### TestImageFactory

Created an in-memory PNG generator.

Benefits:

* No bundled assets
* Fast tests
* Deterministic results
* CI friendly

---

### VisionFoodRecognitionService

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
VNCoreMLRequest
    ↓
FoodPrediction
```

The final Core ML request was intentionally postponed because a model did not exist yet.

---

## Architecture Decisions

### Protocol-Based Dependencies

VisionFoodRecognitionService depends on:

```swift
any ImageConversionService
```

instead of:

```swift
CGImageConverter
```

Benefits:

* Testability
* Replaceable implementations
* Dependency Injection

---

### Swift 6 Actor Isolation

The project uses:

```
Default Actor Isolation: MainActor
```

Infrastructure components opt out:

```swift
nonisolated
```

because they:

* Perform computation
* Own no UI state
* Do not require MainActor isolation

---

## Testing Completed

Implemented:

* PNG conversion succeeds
* Invalid image data throws
* Vision pipeline foundation builds successfully

---

## Concepts Learned

### Repository vs Service

**Repository:**

Provides application-facing capabilities.

**Service:**

Performs a specific operation.

Example:

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

## Why Sprint 1 Stops Here

Vision requires:

```swift
VNCoreMLModel
```

which requires:

```
.mlmodel
```

Without a trained model, completing inference would be premature.

---

## Looking Ahead

Sprint 2 introduces:

* Core ML model loading
* Model integration
* Vision inference
* Prediction conversion

---

## Git History

```
main
|
└── feat/image-processing-service
        |
        ├── feat: add image conversion service protocol
        ├── feat: implement cgimage converter
        ├── test: add cgimage converter tests
        ├── test: add png image factory
        └── feat: scaffold vision food recognition service
```