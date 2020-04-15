//
//  Settings.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

// challenge 2

class Settings: ObservableObject {
    let decks = ["capitals", "math", "cars"]

    @Published var deck = "capitals"
}
