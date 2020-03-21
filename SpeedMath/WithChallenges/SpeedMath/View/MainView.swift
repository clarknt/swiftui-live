//
//  MainView.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Combine
import SwiftUI

struct MainView: View {
    @State private var questions = [Question]()
    @State private var number = 0
    @State private var gameIsRunning = true

    @ObservedObject var chronometer = Chronometer()

    var score: Int {
        var total = 0

        for i in 0..<number {
            if questions[i].userAnswer == questions[i].actualAnswer {
                total += 1
            }
        }

        return total
    }

    var body: some View {
        ZStack {
            ForEach(0..<questions.count, id: \.self) { index in
                QuestionRow(question: self.questions[index], position: self.position(for: index))
                    .offset(x: 0, y: CGFloat(index) * 100 - CGFloat(self.number) * 100)
            }


            if gameIsRunning {
                // challenge 2
                TimerView(chronometer: chronometer)

                ScoreView(score: score)
            }
            else {
                // challenge 1
                RestartView(score: score, time: chronometer.currentTime) {
                    self.number = 0
                    self.questions = []
                    self.createQuestions()
                    self.chronometer.reset()
                    self.chronometer.start()
                    self.gameIsRunning = true
                }
            }
        }
        .frame(width: 1000, height: 600)
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .onAppear {
            self.createQuestions()
            // challenge 2
            self.chronometer.start()
        }
        .onReceive(NotificationCenter.default.publisher(for: .enterNumber)) { note in
            self.enterNumber(note: note)
        }
        .onReceive(NotificationCenter.default.publisher(for: .removeNumber)) { _ in
            _ = self.questions[self.number].userAnswer.popLast()
        }
        .onReceive(NotificationCenter.default.publisher(for: .submitAnswer)) { _ in
            self.submitAnswer()
        }
    }

    func enterNumber(note: NotificationCenter.Publisher.Output) {
        // challenge 1
        guard self.number < self.questions.count else { return }

        guard let number = note.object as? Int else { return }

        // cap at 3 digits
        if self.questions[self.number].userAnswer.count < 3 {
            self.questions[self.number].userAnswer += String(number)
        }
    }

    func submitAnswer() {
        // challenge 1
        if self.number >= self.questions.count - 1 {
            self.gameIsRunning = false
            // challenge 2
            self.chronometer.stop()
        }
        guard self.number < self.questions.count else { return }

        if self.questions[self.number].userAnswer.isEmpty == false {
            withAnimation {
                self.number += 1
            }
        }
    }

    func createQuestions() {
        for _ in 1...50 {
            questions.append(Question())
        }
    }

    func position(for index: Int) -> Position {
        if index < number {
            return .answered
        }
        else if index == number {
            return .current
        }
        else {
            return .upcoming
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
