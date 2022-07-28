//
//  LeftPanel.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

struct LeftPanel: View {
    var body: some View {
        VStack {
            LeftTopPanel()
            LeftBottomPanel()
        }
    }
}

struct LeftPanel_Previews: PreviewProvider {
    static var previews: some View {
        LeftPanel()
    }
}
