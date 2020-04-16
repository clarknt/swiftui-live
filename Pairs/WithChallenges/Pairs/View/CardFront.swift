//
//  CardFront.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct CardFront: View {
    // challenge 1
    let width: CGFloat
    let height: CGFloat
    
    var cardPart: CardPart

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(cardPart.state == .matched ? Color.green : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.white, lineWidth: 2)
                )

            Text(cardPart.text)
                .font(.title)
                .foregroundColor(.black)
                // challenge 1 & 2
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .padding()
        }
        // challenge 1 & 2
        .frame(width: width, height: height)
    }
}


struct CardFront_Previews: PreviewProvider {
    static var previews: some View {
        CardFront(width: 140, height: 100, cardPart: CardPart(id: UUID(), text: "Hello"))
    }
}
