//
//  SettingsButton.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 2

struct SettingsButton: View {
    let action: () -> ()

    var body: some View {
        HStack {

            VStack {
                Spacer()

                Button(action: {
                    self.action()
                }) {
                    Text("⚙")
                        .font(.system(size: 40))
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
