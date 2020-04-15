//
//  CartPart.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

struct CardPart {
    let id: UUID
    let text: String
    var state = CardState.unflipped
}
