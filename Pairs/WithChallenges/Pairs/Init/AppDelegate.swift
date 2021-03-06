//
//  AppDelegate.swift
//  Pairs
//
//  Created by clarknt on 2020-04-15.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.

        // challenge 1 & 2
        let deck = Deck()
        // challenge 4
        let scores = Scores(deck: deck)

        let contentView = MainView()
            .edgesIgnoringSafeArea(.all)
            // challenge 1 & 2
            .environmentObject(deck)
            // challenge 4
            .environmentObject(scores)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.isMovableByWindowBackground = true
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

