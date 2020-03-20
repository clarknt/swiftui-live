//
//  RestartView.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 1
struct RestartView: View {
    let score: Int
    let action: () -> ()

    var body: some View {
        VStack {
            Spacer()

            Text("Score: \(score)")
                .modifier(ScoreTextStyle())

            Button("Restart") {
                self.action()
            }
            .buttonStyle(RestartButtonStyle())
            .padding()
        }
    }
}

struct Restart_Previews: PreviewProvider {
    static var previews: some View {
        RestartView(score: 0, action: {})
    }
}
