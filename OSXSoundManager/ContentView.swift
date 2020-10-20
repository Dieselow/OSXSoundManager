//
//  ContentView.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 20/10/2020.
//

import SwiftUI

struct ContentView: View {
    var applicationManager: ApplicationManager;
    
    init() {
        self.applicationManager = ApplicationManager();
    }

    var body: some View {
        return List(self.applicationManager.getAllRunningApplications(), id: \.localizedName){
            app in ApplicationView(application: app)
        }
    }
}
