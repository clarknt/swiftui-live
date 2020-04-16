//
//  Styles.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 1 & 2
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

// challenge 3
struct PairsButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding()
            .foregroundColor(configuration.isPressed ? Color.black.opacity(0.5) : Color.black.opacity(0.8))
            .background(configuration.isPressed ? Color.white.opacity(0.7) : Color.white)
            .cornerRadius(10)
    }
}

// challenge 3
struct PairsTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)))
            .font(.largeTitle)
            .foregroundColor(.black)
            .animation(nil)
    }
}


struct Styles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("⚙") {
            }
            .buttonStyle(SettingsButtonStyle())
            .padding()

            Button("Start Game") {
            }
            .buttonStyle(PairsButtonStyle())
            .padding()

            Text("Score")
                .modifier(PairsTextStyle())
                .padding()
        }
    }
}
