//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Robert Booth on 2/11/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    let motto1 = Text("Draco dormiens")
//    let motto2 = Text("nunquam titillandus")

    var body: some View {
//        Button("Hello World") {
//            print(type(of: self.body))
//        }
//        .background(Color.red)
//        .frame(width: 200, height: 200)

//        Text("Hello World")
//        .padding()
//        .background(Color.red)
//        .padding()
//        .background(Color.blue)
//        .padding()
//        .background(Color.green)
//        .padding()
//        .background(Color.yellow)

//        VStack {
//            Text("Gryffindor")
//                .font(.largeTitle)
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//        }
//        .font(.subheadline)

//        VStack {
//            Text("Gryffindor")
//                .blur(radius: 0)
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//        }
//        .blur(radius: 5)

//        VStack {
//            motto1
//                .foregroundColor(.red)
//            motto2
//                .foregroundColor(.blue)
//        }

//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//                .foregroundColor(.black)
//            CapsuleText(text: "Second")
//                .foregroundColor(.yellow)
//            Text("Hello World!")
//                .modifier(Title())
//            Text("Extension")
//                .titleStyle()
//
//            Color.blue
//                .frame(width: 300, height: 300)
//                .watermarked(with: "Hacking with Swift")
//        }

        GridStack(rows: 4, columns: 4) { row, col in
            // The HStack can be used, or not because of the initializer in GridStack
//            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
                    .blueTitleStyle()
//            }
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
//            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text("Text")
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        return self.modifier(Title())
    }

    func watermarked(with text: String) -> some View {
        return self.modifier(Watermark(text: text))
    }

    func blueTitleStyle() -> some View {
        return self.modifier(BlueTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
