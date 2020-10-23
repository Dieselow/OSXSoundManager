//
//  ContentView.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 20/10/2020.
//

import SwiftUI

struct ContentView: View {
    var applicationManager: ApplicationManager;
    @State var currentValue = 4.0
    
    init() {
        self.applicationManager = ApplicationManager();
    }
    var title: some View {
        return Slider(value: $currentValue, in: 0.0...10.0)
                            //5. Modify the Slider's color
                            //.accentColor(.orange) not available in macOS
                            .padding()
    }
    var body: some View {
        return VStack {
            Text("Main volume:")
            Slider(value: $currentValue, in: 0.0...10.0)
                                //5. Modify the Slider's color
                                //.accentColor(.orange) not available in macOS
                                .padding()
            List(self.applicationManager.getAllRunningApplications(), id: \.localizedName){
                app in ApplicationView(application: app)
            }
        }
    }
}
