//
//  SetupView.swift
//  MultiplicationGame
//
//  Created by Robert Booth on 3/6/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct SetupView: View {
    @Binding public var isGameRunning: Bool
    @Binding public var table: Int
    @Binding public var questionCount: Int

    @State private var questionChoice: String = "All"

    // Why are these @State when they don't get changed?  I did this to silence the default initializer telling me it couldn't be called cause it was private
    @State private var questionChoices: [String] = [ "Five", "Ten", "Fifteen", "Twenty", "All" ]

    @State private var questionMap: [String:Int] = [
        "Five" : 5,
        "Ten" : 10,
        "Fifteen" : 15,
        "Twenty" : 20,
        "All" : -1
    ]
    
    var body: some View {
        VStack {
            Form {
                Stepper(value: $table, in: 1...12, step: 1) {
                    Text("Table to use: \(table)")
                }
                Picker("Number of questions", selection: $questionChoice) {
                    ForEach(questionChoices, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Button("Start Game") {
                self.questionCount = self.questionMap[self.questionChoice] ?? -1
                self.isGameRunning.toggle()
            }
        }
    }
}
