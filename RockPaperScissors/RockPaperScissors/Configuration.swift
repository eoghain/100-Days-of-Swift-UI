//
//  Configuration.swift
//  RockPaperScissors
//
//  Created by Robert Booth on 2/13/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct Configuration: View {
    @EnvironmentObject var iconSettings = ["Rock", "Paper", "Scissors"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $iconSettings.currentIndex, label: Text("Icons"))
                    {
                        ForEach(0..<iconSettings.iconNames.count) {
                            Text(self.iconSettings.iconNames[$0] ?? "Default")

                        }
                    }.onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in

                        let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0

                        if index != value{
                            UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){ error in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    print("Success!")
                                }
                            }
                        }

                    }
                }

            } .navigationBarTitle("AlternateIcons", displayMode: .inline)
    }
}

struct Configuration_Previews: PreviewProvider {
    static var previews: some View {
        Configuration()
    }
}
