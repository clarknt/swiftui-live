//
//  Styles.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 1
struct RestartButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title)
            .padding()
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.8) : Color.white)
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .cornerRadius(10)
    }
}

struct ScoreTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Capsule().fill(Color.white.opacity(0.8)))
            .font(.largeTitle)
            .foregroundColor(.black)
            .animation(nil)
    }
}

// challenge 2
struct TimerTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Capsule().fill(Color.white.opacity(0.8)))
            .font(Font.largeTitle.monospacedDigit())
            .foregroundColor(.black)
            .animation(nil)
    }
}

// challenge 3
struct SettingsButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 80))
            .padding(.horizontal)
            .padding(.top, -10)
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.8) : Color.white)
            .background(configuration.isPressed ? Color.black.opacity(0.2) : Color.black.opacity(0.25))
            .cornerRadius(.infinity)
    }
}

struct Styles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Score: 0")
                .modifier(ScoreTextStyle())

            Text("00:10.00")
                .modifier(TimerTextStyle())
                .padding()

            Button("Restart") {
            }
            .buttonStyle(RestartButtonStyle())
            .padding()

            Button("⚙") {
            }
            .buttonStyle(SettingsButtonStyle())
            .padding()
        }
    }
}
