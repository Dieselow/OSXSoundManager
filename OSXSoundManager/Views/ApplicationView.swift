//
//  ApplicationView.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 20/10/2020.
//

import SwiftUI

struct ApplicationView: View {
    var application: NSRunningApplication;
    
    var body: some View {
        return HStack {
            Image(nsImage: NSWorkspace.shared.icon(forFile: application.bundleURL?.path ?? "Default value"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22)
                .clipped()
                .cornerRadius(20.0)
            Text("\(self.application.localizedName ?? "Couldn't retrieve name")");
            Spacer()
        }
    }
}
