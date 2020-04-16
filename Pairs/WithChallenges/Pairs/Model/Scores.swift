//
//  Scores.swift
//  Pairs
//
//  Created by clarknt on 2020-04-16.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

// challenge 4

class Scores: ObservableObject {
    let deck: Deck
    private(set) var all = [ScoreKey: [Score]]()

    init(deck: Deck) {
        self.deck = deck

        loadAll()
    }

    /// load all scores
    func loadAll() {
        let userDefaults = UserDefaults.standard

        for difficulty in deck.difficulties {
            for theme in deck.themes {
                all[ScoreKey(difficulty: difficulty, theme: theme)] = [Score]()

                if let encoded = userDefaults.data(forKey: "\(difficulty)\(theme)") {
                    if let highScores = try? JSONDecoder().decode([Score].self, from: encoded) {
                        all[ScoreKey(difficulty: difficulty, theme: theme)] = highScores
                    }
                }
            }
        }

        objectWillChange.send()
    }


    /// add score to the current deck
    func add(score: Score) {
        var scores = all[ScoreKey(difficulty: deck.difficulty, theme: deck.theme)] ?? [Score]()
        scores.append(score)
        scores.sort { $0.score > $1.score }
        all[ScoreKey(difficulty: deck.difficulty, theme: deck.theme)] = scores
        save()

        objectWillChange.send()
    }

    /// get scores for the current deck
    func get() -> [Score] {
        all[ScoreKey(difficulty: deck.difficulty, theme: deck.theme)] ?? [Score]()
    }

    /// save scores for the current deck
    func save() {
        if let scores = all[ScoreKey(difficulty: deck.difficulty, theme: deck.theme)] {
            save(difficulty: deck.difficulty, theme: deck.theme, scores: scores)
        }
    }

    /// save scores for all decks
    func saveAll() {
        for (scoreKey, scores) in all {
            if !scores.isEmpty {
                save(difficulty: scoreKey.difficulty, theme: scoreKey.theme, scores: scores)
            }
        }
    }

    private func save(difficulty: String, theme: String, scores: [Score]) {
        if let encoded = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encoded, forKey: "\(difficulty)\(theme)")
        }
    }
}
