//
//  nbackApp.swift
//  nback
//
//  Created by Denis Gradoboev on 20.07.2022.
//

import SwiftUI

@main
struct nbackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)

        //         .windowToolbarStyle(.automatic)
        
        Settings {
            Text("SETTINGS")
        }
    }
}
