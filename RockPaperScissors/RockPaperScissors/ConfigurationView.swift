//
//  Configuration.swift
//  RockPaperScissors
//
//  Created by Robert Booth on 2/13/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ConfigurationView: View {
    var icons: [Action] = Action.allCases
    @State var currentIcon: Action? = Action(stringValue: UIApplication.shared.alternateIconName ?? "")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            List(icons, id: \.self) { icon in
                Button(action:{ self.changeIcon(icon) }) {
                    HStack {
                        if self.currentIcon == icon {
                            Text(icon.description)
                                .bold()
                        } else {
                            Text(icon.description)
                        }

                        Image(icon.imageName)
                            .renderingMode(.original)
                    }
                }
            } .navigationBarTitle("AlternateIcons", displayMode: .inline)
        }
    }

    func changeIcon(_ icon: Action) {
        UIApplication.shared.setAlternateIconName(icon.description.lowercased(), completionHandler: { (error) in
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }

            self.presentationMode.wrappedValue.dismiss()
        })
    }
}

struct Configuration_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
