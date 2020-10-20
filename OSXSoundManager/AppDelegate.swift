//
//  AppDelegate.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 20/10/2020.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView:ContentView = ContentView();

        // Create the popover
        let popoverCreated = NSPopover();
        popoverCreated.contentSize = NSSize(width: 400, height: 500);
        popoverCreated.behavior = .transient;
        popoverCreated.contentViewController = NSHostingController(rootView: contentView);
        self.popover = popoverCreated;
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength));
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon");
            button.action = #selector(togglePopover(_:));
        }
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
         if let button = self.statusBarItem.button {
              if self.popover.isShown {
                   self.popover.performClose(sender)
              } else {
                   self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
              }
            self.popover.contentViewController?.view.window?.becomeKey()
         }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

