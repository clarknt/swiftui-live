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

struct Styles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("⚙") {
            }
            .buttonStyle(SettingsButtonStyle())
            .padding()
        }
    }
}
