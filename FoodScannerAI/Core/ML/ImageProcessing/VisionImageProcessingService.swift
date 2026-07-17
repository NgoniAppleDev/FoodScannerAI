//
//  VisionImageProcessingService.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation

struct VisionImageProcessingService: ImageProcessingService {
    
    func process(_ imageData: Data) async throws -> Data {
        
        guard !imageData.isEmpty else {
            throw ImageProcessingError.emptyData
        }
        
        return imageData
    }
}
