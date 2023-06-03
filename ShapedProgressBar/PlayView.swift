//
//  PlayView.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 29/05/2023.
//

import SwiftUI

struct PlayView: View {
    
    @AppStorage("settings") var storedSettings: SettingsData = SettingsData.base
    
    @State private var progress = 0.0
    @State private var leadColor = Color.mint
    @State private var trailColor = Color.blue
    @State private var outlineColorHandler: Color = .cyan.opacity(0.1)
    
    @State private var useSlider = true
    @State private var settings = false
    
    var body: some View {
        VStack {
            Label("hello world!", systemImage: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("shaped progress ring tester")
                .font(.caption)
                .foregroundColor(.accentColor)
            if !settings { Spacer() }
            shapesToFlipBy
                .frame(width: 280, height: 280)
                .animation(.default, value: progress)
                .background(Material.ultraThin.opacity(0.5))
                .cornerRadius(28)
            if !settings { Spacer() }
            if useSlider {
                slider
            } else {
                incrementingButtons
            }
            colorControl
            outlineColorControl
            if settings { Spacer() }
            Button {
                withAnimation(.easeOut(duration: 0.2)) { settings = true }
            } label: {
                Label("settings", systemImage: "gear")
            }
        }
        .padding()
        .sheet(isPresented: $settings.animation(.easeOut(duration: 0.2))) { PlayViewSettings(settings: storedSettings) }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                progress = 0.9
            }
            useSlider = storedSettings.useSlider
            if let lead = Color(hex: storedSettings.leadColor, colorSpace: .displayP3) {
                leadColor = lead
            }
            if let trail = Color(hex: storedSettings.trailColor, colorSpace: .displayP3) {
                trailColor = trail
            }
            if let outline = Color(hex: storedSettings.outlineColor ?? "nil", colorSpace: .displayP3) {
                outlineColorHandler = outline
            } else {
                outlineColorHandler = .clear
            }
        }
        .onChange(of: storedSettings.useSlider) { newValue in
            useSlider = newValue
        }
        .navigationTitle("play")
    }
    
    private var shapesToFlipBy: some View {
        TabView {
            progress(shape: Circle()).padding()
            if storedSettings.allowOtherShape {
                progress(shape: Rectangle()).padding()
                progress(shape: RoundedRectangle(cornerRadius: 30)).padding()
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    func progress<S: Shape>(shape: S) -> ShapedProgressBar<S> {
        ShapedProgressBar(shape, value: progress, thickness: 48, leadingColor: leadColor, trailingColor: trailColor, outlinedColor: outlineColor)
    }
    
    private var incrementingButtons: some View {
        HStack {
            Button {
                guard progress > 0 else { return }
                progress -= 0.05
            } label: {
                Label("reduce", image: "minus.square")
            }
            Text(String(format: "%.2f", progress))
            Button {
                progress += 0.05
            } label: {
                Label("increase", image: "plus.square.fill")
            }
        }
    }
    
    private var slider: some View {
        HStack {
            Text("progress")
                .padding(3)
                .padding(.horizontal, 4)
                .background(Material.regular)
                .cornerRadius(8)
            Slider(value: $progress, in: 0.0...storedSettings.maxValue, step: 0.01)
                .tint(leadColor)
            Text(String(format: "%.2f", progress))
                .frame(width: 50)
                .padding(3)
                .background(Material.regular)
                .cornerRadius(8)
        }
    }
    
    private var colorControl: some View {
        HStack {
            ColorPicker("lead", selection: $leadColor, supportsOpacity: false)
                .padding()
                .background(Material.thin)
                .cornerRadius(30)
            ColorPicker("trail", selection: $trailColor, supportsOpacity: false)
                .padding()
                .background(Material.thin)
                .cornerRadius(30)
        }
    }
    
    private var outlineColorControl: some View {
        HStack(spacing: 20) {
            ColorPicker("outline", selection: $outlineColorHandler)
            if outlineColor != nil {
                Button("remove") {
                    withAnimation {
                        outlineColorHandler = .clear
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(trailColor)
                .transition(.move(edge: .trailing).combined(with: .scale(scale: 0.6, anchor: .trailing).combined(with: .opacity)))
            }
        }
        .padding()
        .background(Material.thin)
        .cornerRadius(8)
    }
    
    private var outlineColor: Color? {
        get {
            guard outlineColorHandler != .clear else { return nil }
            
            return outlineColorHandler
        }
        set {
            if let newValue {
                outlineColorHandler = newValue
            } else {
                outlineColorHandler = .clear
            }
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
