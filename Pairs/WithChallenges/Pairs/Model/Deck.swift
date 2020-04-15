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

    init() {
        reloadData(settings: Settings())
    }

    func set(_ index: Int, to state: CardState) {
        cardParts[index].state = state
        // notify all observers of a change
        // not using @Published because of a Swift 5.2 bug (https://bugs.swift.org/browse/SR-12089, https://bugs.swift.org/browse/SR-12178, https://github.com/apple/swift/pull/29931)
        objectWillChange.send()
    }

    // challenge 2
    func reloadData(settings: Settings) {
        allCards = Bundle.main.decode("\(settings.deck).json")

        // pick 12 random cards
        let selectedCards = allCards.shuffled().prefix(12)

        cardParts.removeAll(keepingCapacity: true)
        for card in selectedCards {
            cardParts.append(CardPart(id: card.id, text: card.a))
            cardParts.append(CardPart(id: card.id, text: card.b))
        }

        cardParts.shuffle()
        objectWillChange.send()
    }
}

