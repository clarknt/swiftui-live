//
//  CardView.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct CardView: View {
    // challenge 1
    let width: CGFloat
    let height: CGFloat

    var cardPart: CardPart

    var body: some View {
        ZStack {
            CardBack(width: width, height: height)
                .rotation3DEffect(.degrees(cardPart.state == .unflipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                .opacity(cardPart.state == .unflipped ? 1 : 0)

            CardFront(width: width, height: height, cardPart: cardPart)
                .rotation3DEffect(.degrees(cardPart.state != .unflipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                // if doing 0 instead of -1, the number is visible to soon
                // with -1 it starts being visible halfway through the rotation
                .opacity(cardPart.state != .unflipped ? 1 : -1)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(width: 140, height: 100, cardPart: CardPart(id: UUID(), text: "Hello"))
    }
}
