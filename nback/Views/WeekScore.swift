//
//  WeekScore.swift
//  nback
//
//  Created by Denis Gradoboev on 27.07.2022.
//

import SwiftUI

// Todo:
struct WeekScore: View {
    var body: some View {
        Text("Статистика по дням")
        Image("graph")
    }
}

struct WeekScore_Previews: PreviewProvider {
    static var previews: some View {
        WeekScore()
    }
}
