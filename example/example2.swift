//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Izabela Marcinkowska on 2024-08-25.
//

import SwiftUI

struct example2: View {
    @State private var showingAlert = false
    var body: some View {
        VStack{
            Button("This one is bordered") {}.buttonStyle(.bordered)
            Button("This one is destructive", role: .destructive) {}.buttonStyle(.bordered)
            Button("This is prominent") {}.buttonStyle(.borderedProminent)
            Button("This is prominent and destructive", role: .destructive) {}.buttonStyle(.borderedProminent).tint(.mint)
        }
        Button("Delete selection", role: .destructive, action: executeDelete)
        Button {
            print("Button was snapped")
        } label: {
            Text("Tap me").padding()
                .foregroundStyle(.white)
                .background(.mint)
        }
        Button {
            print("Button was snapped")
            showingAlert = true
        } label: {
            Label("Edit", systemImage: "pencil")
                .padding()
                .background(.green)
        }.alert("Editing in the way", isPresented: $showingAlert) {
            Button("I edited", role: .destructive) {}
        } message: {
            Text("That was important editing")
        }
    }
    func executeDelete() {
        print("Now deleting…")
    }
}

#Preview {
    ContentView()
}
