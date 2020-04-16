//
//  eck.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

class Deck: ObservableObject {
    var allCards = [Card]()
    var cardParts = [CardPart]()

    // challenge 2
    let themes = ["capitals", "math", "cars"]
    var theme = "capitals" {
        didSet {
            reloadData()
        }
    }

    // challenge 1
    let difficulties = ["4x3", "6x4", "7x6"]
    var difficulty = "6x4" {
       didSet {
           reloadData()
       }
   }

    // challenge 1
    var cardRows: Int {
        Int(String(difficulty.suffix(1)))!
    }

    // challenge 1
    var cardColumns: Int {
        Int(String(difficulty.prefix(1)))!
    }

    init() {
        reloadData()
    }

    func set(_ index: Int, to state: CardState) {
        cardParts[index].state = state
        // notify all observers of a change
        // not using @Published because of a Swift 5.2 bug (https://bugs.swift.org/browse/SR-12089, https://bugs.swift.org/browse/SR-12178, https://github.com/apple/swift/pull/29931)
        objectWillChange.send()
    }

    // challenge 1 & 2
    func reloadData() {
        allCards = Bundle.main.decode("\(theme).json")

        // challenge 1 - pick random cards
        let selectedCards = allCards.shuffled().prefix(cardRows * cardColumns / 2)

        cardParts.removeAll(keepingCapacity: true)
        for card in selectedCards {
            cardParts.append(CardPart(id: card.id, text: card.a))
            cardParts.append(CardPart(id: card.id, text: card.b))
        }

        cardParts.shuffle()
        objectWillChange.send()
    }
}

