//
//  SettingsButton.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-23.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 3

struct SettingsButton: View {
    let action: () -> ()

    var body: some View {
        HStack {
//            Spacer()

            VStack {
                Spacer()

                Button(action: {
                    self.action()
                }) {
                    Text("⚙")
                        .font(.system(size: 80))
                }
            .buttonStyle(SettingsButtonStyle())
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(action: { })
    }
}
