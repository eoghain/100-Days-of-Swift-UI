//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Robert Booth on 2/5/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
//            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200).edgesIgnoringSafeArea(.all)
//            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center).edgesIgnoringSafeArea(.all)
//            Text("Hello, World!")
//            Button("Tap me!") {
//                print("Button was tapped")
//            }
            Button(action: {
                print("Edit button was tapped")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                        .renderingMode(.original)
                    Text("Edit")

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
