//
//  GameView.swift
//  MultiplicationGame
//
//  Created by Robert Booth on 3/6/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct Question: CustomStringConvertible {
    let first: Int
    let second: Int
    let answer: Int

    var description: String {
        return "\(first) * \(second) - \(answer)"
    }
}

struct GameView: View {
    @Binding public var isGameRunning: Bool
    @Binding public var table: Int
    @Binding public var questionCount: Int

    @State private var currentQuestion = 0

    private lazy var questions: [Question] = {
        return (1...questionCount).map {
            Question(first: table, second: $0, answer: table * $0)
        }.shuffled()
    }()

    var body: some View {
        VStack {
            Text("Game")
            Text("table: \(table)")
            Text("questionCount: \(questionCount)")
            ForEach(questions) {
                Text("\($0)")
            }
            Button("End Game") {
                self.isGameRunning.toggle()
            }
        }
    }
}
