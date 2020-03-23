//
//  SettingsView.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-23.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 3

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
            Picker(selection: $settings.maxQuestion, label: Text("Questions")) {
                ForEach(settings.maxQuestions, id: \.self) { question in
                    Text("\(question)").tag(question)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Picker(selection: $settings.maxNumber, label: Text("Numbers up to")) {
                ForEach(settings.maxNumbers, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            HStack(alignment: .top) {
                Text("Operations")

                List {
                    ForEach(0..<Operation.allCases.count, id: \.self) { index in
                        HStack {
                            Text("\(Operation.allCases[index].rawValue)")
                            Spacer()
                            if self.settings.operations.contains(Operation.allCases[index]) {
                                Text("✓")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.tapped(operation: Operation.allCases[index])
                        }
                    }
                }
                .frame(height: 100)
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

    func tapped(operation: Operation) {
        // don't remove last element
        if settings.operations.count == 1 {
            guard operation != settings.operations[0] else { return }
        }

        if self.settings.operations.contains(operation) {
            settings.operations.removeAll { $0 == operation }
        }
        else {
            settings.operations.append(operation)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(applyAction: { }).environmentObject(Settings())
    }
}
