//
//  TestImageFactory.swift
//  FoodScannerAITests
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

enum TestImageError: Error {
    case failedToCreateContext
    case failedToCreateImage
    case failedToCreateDestination
    case failedToFinalize
}

nonisolated enum TestImageFactory {
    
    static func makePNGData() throws -> Data {
        
        let width = 10
        let height = 10
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
        ) else {
            throw TestImageError.failedToCreateContext
        }
        
        guard let image = context.makeImage() else {
            throw TestImageError.failedToCreateImage
        }
        
        let data = NSMutableData()
        
        guard let destination = CGImageDestinationCreateWithData(
            data,
            UTType.png.identifier as CFString,
            1,
            nil
        ) else {
            throw TestImageError.failedToCreateDestination
        }
        
        CGImageDestinationAddImage(
            destination,
            image,
            nil
        )
        
        guard CGImageDestinationFinalize(destination) else {
            throw TestImageError.failedToFinalize
        }
        
        return data as Data
    }
}
