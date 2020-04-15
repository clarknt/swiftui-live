//
//  SettingsView.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var settings: Settings

    let applyAction: () -> ()

    @State var selectedOperations = [true, false, false]

    init(applyAction: @escaping () -> ()) {
        self.applyAction = applyAction
    }

    var body: some View {
        VStack {
            Picker(selection: $settings.deck, label: Text("Theme")) {
                ForEach(settings.decks, id: \.self) { pair in
                    Text("\(pair)").tag(pair)
                }
            }

            HStack {
                Spacer()

                Button("Apply and Restart") {
                    self.presentationMode.wrappedValue.dismiss()
                    self.applyAction()
                }
            }
            .padding(.top)
        }
        .padding()
        .frame(width: 300)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(applyAction: { }).environmentObject(Settings())
    }
}
