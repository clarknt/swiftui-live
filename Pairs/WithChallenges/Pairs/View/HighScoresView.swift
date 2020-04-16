//
//  HighScoresView.swift
//  Pairs
//
//  Created by clarknt on 2020-04-16.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 4

struct HighScoresView: View {
    let scores: [Score]
    let currentScore: Score

    var body: some View {
        List {
            ForEach(scores, id: \.id) { score in
                HStack {
                    Text("\(score.score)")
                    Text("-")
                    Text(self.date(from: score))
                }
                .foregroundColor(score.id == self.currentScore.id ? Color.green : Color.white)
            }
        }
    }

    func date(from score: Score) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: score.date)
    }
}

struct HighScoresView_Previews: PreviewProvider {
    static let currentScore = Score(score: 65, date: Date())

    static var previews: some View {
        HighScoresView(scores: [Score(score: 78, date: Date()), currentScore, Score(score: 55, date: Date())], currentScore: Self.currentScore)
    }
}
