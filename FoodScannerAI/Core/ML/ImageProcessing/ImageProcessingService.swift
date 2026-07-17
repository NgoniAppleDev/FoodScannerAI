//
//  ImageProcessingService.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation

protocol ImageProcessingService: Sendable {
    
    func process(_ imageData: Data) async throws -> Data
}
