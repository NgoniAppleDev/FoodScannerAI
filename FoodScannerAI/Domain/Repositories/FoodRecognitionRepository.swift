//
//  FoodRecognitionRepository.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation

protocol FoodRecognitionRepository {
    
    func recognizeFood(from imageData: Data) async throws -> FoodPrediction
}
