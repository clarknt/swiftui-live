//
//  Question.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let actualAnswer: String
    var userAnswer = ""
    var paddingAmount = 0

    // challenge 3
    init(settings: Settings) {
        var left: Int
        var right: Int
        var result: Int

        let currentOperation = settings.operations.randomElement() ?? .addition

        // avoid negative results
        repeat {
            left = Int.random(in: 1...settings.maxNumber)
            right = Int.random(in: 1...settings.maxNumber)
            result = Self.performOperation(operation: currentOperation, left: left, right: right)
        }
        while result < 0

        text = "\(left) \(currentOperation.stringOperator()) \(right) = "
        actualAnswer = "\(result)"

        if left < 10 { paddingAmount += 1 }
        if settings.maxNumber >= 100 && left < 100 { paddingAmount += 1 }
        if settings.maxNumber >= 1000 && left < 1000 { paddingAmount += 1 }

        if right < 10 { paddingAmount += 1 }
        if settings.maxNumber >= 100 && right < 100 { paddingAmount += 1 }
        if settings.maxNumber >= 1000 && right < 1000 { paddingAmount += 1 }
    }

    // challenge 3
    static func performOperation(operation: Operation, left: Int, right: Int) -> Int {
        switch operation {
        case .addition:
            return left + right
        case .multiplication:
            return left * right
        case .substraction:
            return left - right
        }
    }
}
