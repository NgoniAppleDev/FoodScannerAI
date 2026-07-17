//
//  VisionFoodRecognitionService.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation
import Vision

nonisolated struct VisionFoodRecognitionService: FoodRecognitionRepository {
    
    private let converter: any ImageConversionService
    
    init(converter: any ImageConversionService) {
        self.converter = converter
    }
    
    func recognizeFood(from imageData: Data) async throws -> FoodPrediction {
        
        let cgImage = try converter.convert(imageData)
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        _ = handler
        _ = cgImage
        
        // TODO: Create a VNCoreMLRequest using the food classification model.
        // TODO: Execute the Vision request and map the observations to FoodPrediction.
        
        throw VisionError.notImplemented
    }
    
}
