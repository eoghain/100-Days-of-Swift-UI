//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Robert Booth on 2/5/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.25 : 1)
    }
}


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var animationAmount = 0.0
    @State private var animateFlag = -1
    @State private var opacityValue = 1.0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Current Score: \(score)")
                        .font(.subheadline)
                        .fontWeight(.thin)
                }
                .foregroundColor(.white)

                ForEach(0..<3) { number in
                    Button(action: {
                        if self.flagTapped(number) {
                            withAnimation(.default) {
                                self.animationAmount += 360
                                self.opacityValue = 0.25
                            }
                        }
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                            .rotation3DEffect(.degrees(self.animateFlag == number ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0) )
                    }
                    .opacity(self.animateFlag == number ? 1 : self.opacityValue)
//                    .buttonStyle(ScaleButtonStyle())
                }

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) -> Bool {
        showingScore = true

        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            animateFlag = number
            return true
        }

        score -= 1
        scoreTitle = "Wrong, that is the flag for \(countries[number])"

        return false
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationAmount = 0
        animateFlag = -1
        opacityValue = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
