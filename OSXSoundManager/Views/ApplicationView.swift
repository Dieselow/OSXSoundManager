//
//  ApplicationView.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 20/10/2020.
//

import SwiftUI

struct ApplicationView: View {
    var application: NSRunningApplication;  
    @State var currentValue = 4.0;
    var body: some View {
        return HStack {
            Image(nsImage: NSWorkspace.shared.icon(forFile: application.bundleURL?.path ?? "Default value"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22)
                .clipped()
                .cornerRadius(20.0)
            Text("\(self.application.localizedName ?? "Couldn't retrieve name")");
            Slider(value: $currentValue, in: 0.0...10.0)
                                //5. Modify the Slider's color
                                //.accentColor(.orange) not available in macOS
                                .padding()
            Spacer()
        }
    }
}
