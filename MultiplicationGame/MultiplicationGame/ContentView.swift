//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Robert Booth on 3/6/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isGameRunning = false
    @State private var table: Int = 1
    @State private var questionCount: Int = -1

    var body: some View {
        Group {
            if isGameRunning {
                GameView(isGameRunning: $isGameRunning, table: $table, questionCount: $questionCount)
            } else {
                SetupView(isGameRunning: $isGameRunning, table: $table, questionCount: $questionCount)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
