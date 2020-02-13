//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Robert Booth on 2/12/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]

    @State var appChoice: Int = Int.random(in: 0...2)
    @State var shouldWin: Bool = Bool.random()
    @State var userChoice: Int = -1
    @State var score: Int = 0
    @State var round: Int = 1

    var body: some View {
        NavigationView {
            VStack {
                if round > 10 {
                    Text("You got \(score) correct!")
                    Button("  New Game  ") {
                        self.round = 1
                        self.score = 0
                    }
                    .gameButtonStyle()
                    .padding(.top, 10)
                } else {
                    Text("Round \(round) of 10")
                        .font(.title)
                        .underline()
                        .padding(.bottom, 10)
                    Text("Computer chose: \(self.moves[self.appChoice])")
                    if shouldWin {
                        Text("You must win")
                    } else {
                        Text("You must lose")
                    }
                    HStack {
                        ForEach(moves, id: \.self) { buttonName in
                            Button("  \(buttonName)  ") {
                                self.processChoice(for: buttonName)
                            }
                            .gameButtonStyle()
                        }
                    }
                    .padding(.top, 15)
                }

                Spacer()
            }
            .padding(.top, 25)
            .edgesIgnoringSafeArea([.leading, .trailing])
            .navigationBarTitle("Rock, Paper, Scissors", displayMode: .inline)
        }
    }

    func processChoice(for buttonName: String) {
        userChoice = self.moves.firstIndex(of: buttonName) ?? -1
        switch (userChoice, appChoice) {
        case (0,1): score += shouldWin ? 0 : 1
        case (0,2): score += shouldWin ? 1 : 0
        case (1,0): score += shouldWin ? 1 : 0
        case (1,2): score += shouldWin ? 0 : 1
        case (2,0): score += shouldWin ? 0 : 1
        case (2,1): score += shouldWin ? 1 : 0
        default: break; // ties don't score
        }

        round += 1
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct GameButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

extension View {
    func gameButtonStyle() -> some View {
        self.modifier(GameButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
