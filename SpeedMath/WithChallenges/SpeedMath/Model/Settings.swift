//
//  Settings.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-23.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

// challenge 3

enum Operation: String, CaseIterable {
    case addition = "Addition"
    case multiplication = "Multiplication"
    case substraction = "Substraction"

    func stringOperator() -> String {
        switch self {
        case .addition:
            return "+"
        case .multiplication:
            return "x"
        case .substraction:
            return "-"
        }
    }
}

class Settings: ObservableObject {
    let maxQuestions = [5, 10, 20, 50, 100]
    let maxNumbers = [10, 100, 1000]

    @Published var maxQuestion = 50

    // numbers in questions will range from 1 to maxNumber,
    @Published var maxNumber = 10

    @Published var operations: [Operation] = [.addition]

}
