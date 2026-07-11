//
//  VisionImageProcessingServiceTests.swift
//  FoodScannerAITests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Testing
import Foundation
@testable import FoodScannerAI

struct VisionImageProcessingServiceTests {

    @Test
    func processReturnsValidImageData() async throws {
        
        let service = VisionImageProcessingService()
        
        let input = Data([0x01, 0x02])
        
        let result = try await service.process(input)
        
        #expect(result == input)
    }
    
    @Test
    func processThrowsForEmptyData() async throws {
        
        let service = VisionImageProcessingService()
        
        await #expect(throws: ImageProcessingError.emptyData) {
            try await service.process(Data())
        }
    }

}
