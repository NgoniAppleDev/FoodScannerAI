//
//  RecognizeFoodUseCaseTests.swift
//  FoodScannerAITests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Testing
import Foundation
@testable import FoodScannerAI

struct RecognizeFoodUseCaseTests {

    @Test
    func recognizeFoodReturnsPrediction() async throws {
        
        let repository = MockFoodRecognitionRepository()
        
        let expected = FoodPrediction(foodName: "Banana", confidence: 0.95)
        
        await repository.setResult(expected)
        
        let useCase = await RecognizeFoodUseCase(repository: repository)
        
        let result = try await useCase.execute(imageData: Data())
        
        #expect(result.foodName == "Banana")
    }

}
