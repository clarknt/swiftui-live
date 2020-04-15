//
//  Card.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

struct Card: Codable {
    let id = UUID()
    let a: String
    let b: String
}
