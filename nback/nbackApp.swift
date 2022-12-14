//
//  nbackApp.swift
//  nback
//
//  Created by Denis Gradoboev on 20.07.2022.
//

import SwiftUI

@main
struct nbackApp: App {
    @AppStorage("SESSION_TIME_MINUTE") var sessionTime: Double = 15

    var body: some Scene {
        WindowGroup {
            ContentView(sessionTime: Int(sessionTime))
                .frame(minWidth: 1300, idealWidth: 1300, maxWidth: 1300, minHeight: 800, idealHeight: 800, maxHeight: 800)
        }
        .windowStyle(.hiddenTitleBar)
        
        Settings {
            SettingsMenu(sessionTime: $sessionTime)
        }
    }
}
