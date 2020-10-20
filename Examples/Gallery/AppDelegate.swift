//
//  AppDelegate.swift
//  Gallery
//
//  Created by Vojta Molda on 10/27/20.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        let hostingView = NSHostingView(rootView: contentView)
        
        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(origin: .zero, size: hostingView.fittingSize),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.contentView = hostingView

        window.isReleasedWhenClosed = false
        window.titlebarAppearsTransparent = true
        window.setFrameAutosaveName("Gallery")
        window.makeKeyAndOrderFront(nil)
        window.center()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

