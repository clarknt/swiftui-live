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

    init() {
        let left = Int.random(in: 1...10)
        let right = Int.random(in: 1...10)

        text = "\(left) + \(right) = "
        actualAnswer = "\(left + right)"

        if left < 10 {
            paddingAmount += 1
        }

        if right < 10 {
            paddingAmount += 1
        }
    }
}
