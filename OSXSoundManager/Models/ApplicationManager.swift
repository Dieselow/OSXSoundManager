//
//  ApplicationManager.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 20/10/2020.
//

import Cocoa

class ApplicationManager {
    var apps = [NSRunningApplication]();
    init() {
        apps = initRunningApplications();
    }
    
    func initRunningApplications() -> [NSRunningApplication] {
        let runningApps = NSWorkspace.shared.runningApplications;
        return runningApps.filter({app in return app.activationPolicy == .regular});
    }
    
    func getAllRunningApplications() -> [NSRunningApplication] {
        return self.apps;
    }
}
