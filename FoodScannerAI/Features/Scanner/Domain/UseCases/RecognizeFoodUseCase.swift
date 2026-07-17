//
//  RecognizeFoodUseCase.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation

struct RecognizeFoodUseCase {
    
    private let repository: any FoodRecognitionRepository
    
    init(repository: any FoodRecognitionRepository) {
        self.repository = repository
    }
    
    func execute(imageData: Data) async throws -> FoodPrediction {
        
        try await repository.recognizeFood(from: imageData)
    }
}
