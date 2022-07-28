//
//  Sidebar.swift
//  nback
//
//  Created by Denis Gradoboev on 22.07.2022.
//

import SwiftUI

enum GameMode: String, CaseIterable {
    case career = "Career 🎢"
    case manual = "Manual ⚙️"
    case random = "Random 🎲"
}

struct Sidebar: View {
    @State private var selectedGameMode: GameMode = .career
    @State private var level: Int = 2
    
    var body: some View {
        List {
            Text("Game mode")
            Picker("", selection: $selectedGameMode, content: {
                ForEach(GameMode.allCases, id:\.rawValue) {gameMode in
                    Text(gameMode.rawValue).tag(gameMode)
                }
            })
            .pickerStyle(.segmented)

        }.listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
