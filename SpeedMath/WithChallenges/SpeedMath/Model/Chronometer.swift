//
//  Chronometer.swift
//  SpeedMath
//
//  Created by clarknt on 2020-03-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

// challenge 2

// class inspired by objc.io https://github.com/objcio/S01E183-lap-times
class Chronometer: ObservableObject {

    private var timer: Timer?

    private var startTime: TimeInterval?
    @Published private(set) var currentTime: TimeInterval = 0

    deinit {
        stop()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            if let startTime = self?.startTime {
                self?.currentTime = Date().timeIntervalSinceReferenceDate - startTime
            }
        }
        startTime = Date().timeIntervalSinceReferenceDate
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        startTime = nil
    }

    func reset() {
        stop()
        currentTime = 0
    }
}
