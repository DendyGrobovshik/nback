//
//  TodayScore.swift
//  nback
//
//  Created by Denis Gradoboev on 27.07.2022.
//

import SwiftUI

func gradientColor(_ score: Int) -> [Color] {
    switch score {
    case _ where score < 50:
        return [.black, .red]
    case _ where score < 70:
        return [.red, .orange]
    case _ where score < 90:
        return [.orange, .green]
    default:
        return [.green]
    }
}

struct TodayScore: View {
    @Binding var scores: [Set]
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(20)), count: 2)
    
    var body: some View {
        VStack {
            Text("Latest sets:")
                .font(.largeTitle)
                .gradient(colors: [.teal, .pink])
            ForEach(scores) {set in
                HStack {
                    Text("\(String(set.score))%")
                        .font(.system(size: 30))
                        .fontWeight(.black)
                        .foregroundColor(Color.black)
                        .gradient(colors: gradientColor(set.score))
                    Spacer()
                        .frame(maxWidth: 40)
                    Text("for")
                        .font(.system(size: 30))
                    Spacer()
                        .frame(maxWidth: 40)
                    Text(set.mode)
                        .font(.system(size: 40))
                        .foregroundColor(Color.black)
                        .gradient(colors: [.yellow, .orange])

                }
                .padding()
                .frame(width: 300, height: 50, alignment: .leading)
                .background(LinearGradient(colors: [.blue.opacity(0.6), .indigo.opacity(0.6)], startPoint: .topLeading, endPoint: .bottom))
                .cornerRadius(20)
            }
        }
        .frame(width: 350, height: 500)
    }
}

struct TodayScore_Previews: PreviewProvider {
    static var previews: some View {
        TodayScore(scores: .constant([
            Set(mode: "2P", score: 30),
            Set(mode: "3P", score: 65),
            Set(mode: "4P", score: 56),
            Set(mode: "5PA", score: 89),
            Set(mode: "5PA", score: 69),
            Set(mode: "3A", score: 98),
            Set(mode: "2PA", score: 89),
        ]))
    }
}
