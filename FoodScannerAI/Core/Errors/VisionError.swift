//
//  VisionError.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation

enum VisionError: Error {
    
    case notImplemented
    case failedToCreateRequest
    case requestFailed(Error)
    case noPrediction
}
