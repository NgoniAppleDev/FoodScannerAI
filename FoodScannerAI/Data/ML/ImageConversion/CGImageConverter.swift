//
//  CGImageConverter.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation
import CoreGraphics
import ImageIO

nonisolated struct CGImageConverter: ImageConversionService {
    
    func convert(_ data: Data) throws -> CGImage {
        
        guard let source = CGImageSourceCreateWithData(data as CFData, nil)
        else { throw ImageConversionError.invalidImageData }
        
        let count = CGImageSourceGetCount(source)
        
        guard count > 0 else {
            throw ImageConversionError.invalidImageData
        }
        
        guard let image = CGImageSourceCreateImageAtIndex(source, 0, nil)
        else { throw ImageConversionError.failedToCreateImage }
        
        return image
    }
}
