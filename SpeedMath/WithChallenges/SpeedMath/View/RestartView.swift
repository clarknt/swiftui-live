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
    // challenge 2
    let time: TimeInterval
    let action: () -> ()

    var body: some View {
        VStack {
            Spacer()

            Text("Score: \(score)")
                .modifier(ScoreTextStyle())

            // challenge 2
            Text("Time: \(time.formatted)")
                .modifier(TimerTextStyle())
                .padding()
            
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
        RestartView(score: 0, time: 10.0, action: {})
    }
}
