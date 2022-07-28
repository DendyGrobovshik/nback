//
//  Home.swift
//  nback
//
//  Created by Denis Gradoboev on 22.07.2022.
//

import SwiftUI

struct Home: View {
    @State var currentTab: String = "bag"
    
    var body: some View {
        HStack(spacing:0) {
            VStack(spacing: 20) {
                ForEach(["person", "person", "bag", "star", "star", "star"], id: \.self){image in
                     menuButton(image: image)
                }
            }
            .padding(.top, 60)
            .frame(width: 85)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(
                ZStack{
                    Color.white
                        .padding(.trailing, 30)
                    
                    Color.white
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.03), radius: 5, x: 5, y: 0)
                }
            )
        }
        .frame(width: getRect().width / 1.75, height: getRect().height - 130, alignment: .leading)
        .background(Color("BG").ignoresSafeArea())
        .buttonStyle(BorderlessButtonStyle())
    }
    
    @ViewBuilder
    func menuButton(image: String) -> some View {
        Button {
            
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(currentTab == image ? .black : .gray)
                .frame(width: 22, height: 22)
                .frame(width: 80, height: 50)
                .overlay(
                    HStack{
                        if currentTab == image {
                            Capsule()
                                .fill(.black)
                                .frame(width: 2)
                        }
                    }
                    , alignment: .trailing
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect()->CGRect{
        return NSScreen.main!.visibleFrame
    }
}
