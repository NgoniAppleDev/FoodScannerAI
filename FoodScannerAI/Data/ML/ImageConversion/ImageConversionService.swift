//
//  ImageConversionService.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation
import CoreGraphics

nonisolated protocol ImageConversionService: Sendable {
    
    func convert(_ data: Data) throws -> CGImage
}
