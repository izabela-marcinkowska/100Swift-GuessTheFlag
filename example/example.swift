//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Izabela Marcinkowska on 2024-08-25.
//

import SwiftUI

struct example: View {
    var body: some View {
        ZStack{
            VStack (spacing: 0) {
                Color.orange
                Color.purple
            }
            Text("This is frosted")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }.ignoresSafeArea()
        VStack (alignment: .center , spacing: 20){
            Spacer()
            Spacer()
            Text("Much spacing")
            Text("Here comes smaller box")
            Color.secondary
                .frame(width: 200, height: 50)
        }
        VStack{
            Color(red: 1, green: 0.8, blue: 0)
                
            Text("This is custom color")
            LinearGradient(stops: [.init(color: .white, location: 0.45), .init(color: .black, location: 0.55)], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    ContentView()
}
