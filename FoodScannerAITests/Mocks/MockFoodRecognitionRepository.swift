//
//  MockFoodRecognitionRepository.swift
//  FoodScannerAITests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation
@testable import FoodScannerAI

actor MockFoodRecognitionRepository: FoodRecognitionRepository {
    
    private(set) var receivedImageData: Data?
    
    var result: FoodPrediction?
    
    func recognizeFood(from imageData: Data) async throws -> FoodPrediction {
        
        receivedImageData = imageData
        
        guard let result else {
            throw MockError.missingResult
        }
        
        return result
    }
    
    func setResult(_ result: FoodPrediction) {
        self.result = result
    }
}
