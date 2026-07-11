//
//  CGImageConverterTests.swift
//  FoodScannerAITests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Testing
import Foundation
import CoreGraphics
@testable import FoodScannerAI

struct CGImageConverterTests {
    
    @Test
    func convertsPNGDataToCGImage() throws {
        
        let converter = CGImageConverter()
        
        let data = try TestImageFactory.makePNGData()
        
        let image = try converter.convert(data)
        
        #expect(image.width > 0)
        #expect(image.height > 0)
    }
    
    @Test
    func throwsForInvalidImageData() throws {
        
        let converter = CGImageConverter()
        
        let data = Data([1, 2, 3])
        
        #expect(throws: ImageConversionError.invalidImageData) {
            try converter.convert(data)
        }
    }
    
}
