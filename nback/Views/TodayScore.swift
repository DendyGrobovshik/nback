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
            ForEach(scores) {s in
                HStack {
                    Text("\(String(s.getScore()))")
                        .font(.system(size: 30))
                        .fontWeight(.black)
                    Spacer()
                        .frame(maxWidth: 0)
                    Text("(\(String(s.percent))%)")
                        .font(.system(size: 18))
                        .fontWeight(.black)
                        .foregroundColor(Color.black)
                        .gradient(colors: gradientColor(s.percent))
                    Spacer()
                        .frame(maxWidth: 20)
                    Text("for")
                        .font(.system(size: 25))
                    Spacer()
                        .frame(maxWidth: 30)
                    Text(s.getMode())
                        .font(.system(size: 32))
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
            Set(level: 2, selectedModes: ["Position"], percent: 65),
            Set(level: 3, selectedModes: ["Position", "Audio"], percent: 56),
            Set(level: 2, selectedModes: ["Position", "Audio"], percent: 89),
            Set(level: 5, selectedModes: ["Position"], percent: 98),
            Set(level: 4, selectedModes: ["Position", "Audio"], percent: 77),
            //            Set(mode: "3P", score: 65),
            //            Set(mode: "4P", score: 56),
            //            Set(mode: "5PA", score: 89),
            //            Set(mode: "5PA", score: 69),
            //            Set(mode: "3A", score: 98),
            //            Set(mode: "2PA", score: 89),
        ]))
    }
}
