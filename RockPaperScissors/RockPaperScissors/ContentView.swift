//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Robert Booth on 2/12/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

enum Action: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2

    init?(stringValue: String) {
        switch stringValue {
        case "Rock", "rock": self = .rock
        case "Paper", "paper": self = .paper
        case "Scissors", "scissors": self = .scissors
        default: return nil
        }
    }

    static var random: Action {
        // Force unwrap cause this can't ever fail
        // Note need to adjust the range if you ever add
        // more cases (i.e. lizard, spock)
        return self.init(rawValue: Int.random(in: 0...2))!
    }

    var imageName: String {
        return self.description
    }
    
    func beats(_ action: Action) -> Bool? {
        guard action != self else { return nil }
        switch self {
        case .rock: return action == .scissors
        case .paper: return action == .rock
        case .scissors: return action == .paper
        }
    }
}

extension Action: CustomStringConvertible {
    var description: String {
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        }
    }
}

struct ContentView: View {
    @State var appAction: Action = Action.random
    @State var shouldWin: Bool = Bool.random()
    @State var userChoice: Int = -1
    @State var userScore: Int = 0
    @State var appScore: Int = 0
    @State var round: Int = 1

    @State private var showConfig = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Score")
                    .font(.title)
                HStack {
                    Text("User")
                        .font(.subheadline)

                    Text("\(self.userScore) : \(self.appScore)")
                        .font(.title)
                        .bold()
                        .fixedSize(horizontal: true, vertical: true)

                    Text("App")
                        .font(.subheadline)
                }
                .edgesIgnoringSafeArea([.leading, .trailing])
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(UIColor(named: "borderColor") ?? .black), lineWidth: 1)
                )
                .padding(.bottom, 25)

                if round > 10 {
                    Button("  New Game  ") {
                        self.round = 1
                        self.userScore = 0
                        self.appScore = 0
                    }
                    .gameButtonStyle()
                    .padding(.top, 10)
                } else {
                    VStack {
                        Text("Computer chose")
                        Image(appAction.imageName)
                    }
                    if shouldWin {
                        Text("You must win")
                    } else {
                        Text("You must lose")
                    }
                    HStack {
                        ForEach(Action.allCases, id: \.self) { action in
                            Button(action: {
                                self.processChoice(for: action)
                            }) {
                                Image(action.imageName)
                                    .renderingMode(.original)
                            }
                        }
                    }
                    .padding(.top, 15)

                    Text("Round \(round) of 10")
                        .font(.title)
                        .underline()
                        .padding(.bottom, 10)
                }

                Spacer()
            }
            .padding(.top, 25)
            .edgesIgnoringSafeArea([.leading, .trailing])
            .navigationBarTitle("Rock, Paper, Scissors", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
print(UIApplication.shared.alternateIconName)
                    self.showConfig.toggle()
                }) {
                    Image(systemName: "gear")
                }
                .sheet(isPresented: $showConfig) {
                    ConfigurationView()
                }
            )
        }
    }

    func processChoice(for userAction: Action) {
        if let userWon = userAction.beats(appAction) {
            userScore += shouldWin == userWon ? 1 : 0
            appScore += shouldWin == userWon ? 0 : 1
        }

        round += 1
        appAction = Action.random
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
