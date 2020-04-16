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

    @EnvironmentObject var deck: Deck

    let applyAction: () -> ()

    init(applyAction: @escaping () -> ()) {
        self.applyAction = applyAction
    }

    var body: some View {
        VStack {
            Picker(selection: $deck.difficulty, label: Text("Difficulty")) {
                ForEach(deck.difficulties, id: \.self) { difficulty in
                    Text("\(difficulty)").tag(difficulty)
                }
            }

            Picker(selection: $deck.deck, label: Text("Theme")) {
                ForEach(deck.decks, id: \.self) { pair in
                    Text("\(pair)").tag(pair)
                }
            }

            HStack {
                Spacer()

                Button("Restart game") {
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
        SettingsView(applyAction: { }).environmentObject(Deck())
    }
}
