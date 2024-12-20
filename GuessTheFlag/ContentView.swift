//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Izabela Marcinkowska on 2024-08-25.
//

import SwiftUI

extension View {
    func goBlue() -> some View {
        modifier(BlueText())
    }
}

struct BlueText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingEndGame = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var score = 0
    @State private var round = 1
    @State private var scaleAmount = 1.0
    
    @State private var animationAmount = 0.0
    @State private var selected = 100
    @State private var opacity = 1.0
    var endGameTitle = "Game is over."
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 1.0, green: 0.8, blue: 0.788), location: 0.3),
                .init(color: Color(red: 1.0, green: 0.337, blue: 0.4), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(Color(red: 1.0, green: 0.337, blue: 0.4))
                Spacer()
                VStack (spacing: 15 ){
                    VStack (spacing: 15) {
                        Text("Tap the flag of")
                            .goBlue()
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation {
                                animationAmount += 360
                                opacity = 0.25
                                scaleAmount = 0.5
                            }
                        } label: {
                            FlagImage(picture: countries[number])
                        }
                        .rotation3DEffect(.degrees((number == selected ? animationAmount : 0.0)), axis: (x: 0, y: 1, z: 0))
                        .opacity(number != selected ? opacity : 1)
                        .scaleEffect(number != selected ? scaleAmount : 1)
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 15)
                Spacer()
                VStack (spacing: 10){
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Text("Round: \(round)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
            }.padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }.alert(endGameTitle, isPresented: $showingEndGame) {
            Button("Play again", action: gameOver)
        } message: {
            Text("You got \(score) points.")
        }
    }
    
    func flagTapped (_ number: Int) {
        selected = number
        if round == 7 {
            showingEndGame = true
        }
        if number == correctAnswer {
            scoreTitle = "Correct! "
            score += 1
            round += 1
        } else {
            scoreTitle = "Wrong. This is flag of \(countries[number])"
            round += 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selected = 100
        opacity = 1
        scaleAmount = 1
    }
    
    func gameOver() {
        score = 0
        round = 0
        askQuestion()
    }
    
    struct FlagImage: View {
        var picture: String
        var body: some View {
            Image(picture)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    ContentView()
}
