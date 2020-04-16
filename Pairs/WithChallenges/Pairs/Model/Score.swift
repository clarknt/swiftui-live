//
//  Score.swift
//  Pairs
//
//  Created by clarknt on 2020-04-16.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

// challenge 4

struct Score: Codable {
    let id = UUID()
    let score: Int
    let date: Date
}
