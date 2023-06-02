//
//  PlayViewSettings.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 01/06/2023.
//

import SwiftUI

struct PlayViewSettings: View {
    
    @AppStorage("settings") var settings: SettingsData = .base
    
    @State private var maxValue = "1.50"
    
    var body: some View {
        NavigationView {
            List {
                Section("colors after relaunch") {
                    ColorPicker("leading color", selection: leadColor, supportsOpacity: false)
                    ColorPicker("trailing color", selection: trailColor, supportsOpacity: false)
                    HStack {
                        ColorPicker("outline color", selection: outlineColor)
                        if settings.outlineColor != nil {
                            Button("remove outline") {
                                withAnimation {
                                    settings.outlineColor = nil
                                }
                            }
                            .buttonStyle(.bordered)
                            .transition(.scale)
                        }
                    }
                }
                
                Section("value") {
                    Toggle("use slider", isOn: $settings.animation().useSlider)
                    if settings.useSlider {
                        LabeledContent("max value") {
                            TextField("5.50", text: $maxValue)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                .onAppear {
                    maxValue = String(format: "%.2f", settings.maxValue)
                }
                .onChange(of: maxValue) { text in
                    let value = Double(text) ?? 1.5
                    settings.maxValue = value
                }
                
                Section {
                    Toggle("show other shapes", isOn: $settings.allowOtherShape)
                } footer: {
                    Text("please note other shapes are in their experimental phase and won't work as exepcted")
                }
            }
            .navigationTitle("settings")
        }
        .overlay(alignment: .bottom) {
            ButtonNeedingConfimation(name: "reset to defaults", role: .destructive, systemSymbol: "x.square") {
                settings = .base
            }
            .transformationAnimation(.spring(response: 0.3))
            .padding()
        }
    }
    var leadColor: Binding<Color> {
        .init {
            Color(hex: settings.leadColor, colorSpace: .displayP3) ?? .clear
        } set: { color in
            settings.leadColor = color.hexValue ?? "#000000"
        }
    }
    
    var trailColor: Binding<Color> {
        .init {
            Color(hex: settings.trailColor, colorSpace: .displayP3) ?? .clear
        } set: { color in
            settings.trailColor = color.hexValue ?? "#000000"
        }
    }
    
    var outlineColor: Binding<Color> {
        .init {
            Color(hex: settings.outlineColor ?? "nil", colorSpace: .displayP3) ?? .clear
        } set: { color in
            settings.outlineColor = color.hexValue
        }
    }
}

struct PlayViewSettings_Previews: PreviewProvider {
    static var previews: some View {
        PlayViewSettings()
    }
}
