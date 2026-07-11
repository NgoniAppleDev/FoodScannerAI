//
//  ScannerViewModel.swift
//  FoodScannerAI
//
//  Created by Ngoni Katsidzira  on 11/7/2026.
//

import Foundation

@MainActor
final class ScannerViewModel {
    
    private let recognizeFoodUseCase: RecognizeFoodUseCase
    
    var prediction: FoodPrediction?
    
    init(recognizeFoodUseCase: RecognizeFoodUseCase) {
        self.recognizeFoodUseCase = recognizeFoodUseCase
    }
}
