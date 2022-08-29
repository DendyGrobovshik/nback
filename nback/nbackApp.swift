//
//  nbackApp.swift
//  nback
//
//  Created by Denis Gradoboev on 20.07.2022.
//

import SwiftUI

@main
struct nbackApp: App {
    let notify = NotificationHandler()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        
        //         .windowToolbarStyle(.automatic)
        
        Settings {
            VStack {
                Button("Ask permission for notification") {
                    notify.askPermission()
                }
                Button("Enable everyday notifications") {
                    notify.sendNotification()
                }
            }
            .padding()
        }
    }
}
