//
//  QuestionRow.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

enum Position {
    case answered, current, upcoming
}

struct QuestionRow: View {
    var question: Question
    var position: Position

    var positionColor: Color {
        if position == .answered {
            if question.actualAnswer == question.userAnswer {
                return Color.green.opacity(0.8)
            }
            else {
                return Color.red.opacity(0.8)
            }
        }
        else if position == .upcoming {
            return Color.black.opacity(0.5)
        }
        else {
            return .blue
        }
    }

    var body: some View {
        HStack {
            HStack(spacing: 0) {
                if question.paddingAmount > 0 {
                    Text(String(repeating: " ", count: question.paddingAmount))
                }

                Text(question.text)
            }
            .padding([.top, .bottom, .leading])

            ZStack {
                Text(" ")
                .padding()
                // challenge 3
                .frame(width: 250)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(positionColor)
                )

                Text(question.userAnswer)
            }
        }
        .font(.system(size: 48, weight: .regular, design: .monospaced))
        .foregroundColor(.white)
    }
}

struct QuestionRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            QuestionRow(question: Question(settings: Settings()), position: .answered)
            QuestionRow(question: Question(settings: Settings()), position: .current)
            QuestionRow(question: Question(settings: Settings()), position: .upcoming)
        }
    }
}
