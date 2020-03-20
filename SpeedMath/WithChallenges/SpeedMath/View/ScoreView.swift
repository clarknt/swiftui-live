//
//  ScoreView.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    let score: Int

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Text("Score: \(score)")
                    .modifier(ScoreTextStyle())
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct RunningScore_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 0)
    }
}
