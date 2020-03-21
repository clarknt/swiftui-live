//
//  TimerView.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 2

// extension inspired by objc.io https://github.com/objcio/S01E183-lap-times
extension TimeInterval {
    static let formatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        f.allowedUnits = [.minute, .second]
        f.zeroFormattingBehavior = .pad
        return f
    }()

    static let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        f.maximumIntegerDigits  = 0
        f.alwaysShowsDecimalSeparator = true
        return f
    }()

    var formatted: String {
        let ms = self.truncatingRemainder(dividingBy: 1)
        return Self.formatter.string(from: self)! + Self.numberFormatter.string(from: NSNumber(value: ms))!
    }
}

struct TimerView: View {
    @ObservedObject var chronometer: Chronometer

    var body: some View {
        VStack {
            HStack {
                Text("\(chronometer.currentTime.formatted)")
                    .modifier(TimerTextStyle())

                Spacer()
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(chronometer: Chronometer())
    }
}
