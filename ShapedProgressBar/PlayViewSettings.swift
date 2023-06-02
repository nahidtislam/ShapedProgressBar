//
//  PlayViewSettings.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 01/06/2023.
//

import SwiftUI

struct PlayViewSettings: View {
    var body: some View {
        NavigationView {
            List {
                Section("colors after relaunch") {
                    ColorPicker("leading color", selection: .constant(.mint))
                    ColorPicker("trailing color", selection: .constant(.blue))
                }
                
                Section("value") {
                    Toggle("use slider", isOn: .constant(true))
                    LabeledContent("max value") {
                        TextField("5.50", text: .constant(""))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    Toggle("show other shapes", isOn: .constant(true))
                } footer: {
                    Text("please note other shapes are in their experimental phase and won't work as exepcted")
                }
            }
            .navigationTitle("settings")
        }
    }
}

struct PlayViewSettings_Previews: PreviewProvider {
    static var previews: some View {
        PlayViewSettings()
    }
}
