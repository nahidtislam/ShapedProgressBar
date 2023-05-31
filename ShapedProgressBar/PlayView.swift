//
//  PlayView.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 29/05/2023.
//

import SwiftUI

struct PlayView: View {
    
    @State private var progress = 0.0
    @State private var leadColor = Color.mint
    @State private var trailColor = Color.blue
    
    @State private var useSlider = true
    
    var body: some View {
        VStack {
            Label("hello world!", systemImage: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            shapesToFlipBy
                .animation(.default, value: progress)
                .frame(width: 280, height: 280)
            if useSlider {
                slider
            } else {
                incrementingButtons
            }
            colorControl
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                progress = 0.9
            }
        }
    }
    
    private var shapesToFlipBy: some View {
        TabView {
            progress(shape: Circle()).padding()
            progress(shape: Rectangle()).padding()
            progress(shape: RoundedRectangle(cornerRadius: 30)).padding()
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    func progress<S: Shape>(shape: S) -> ShapedProgressBar<S> {
        ShapedProgressBar(shape, value: progress, thickness: 48, leadingColor: leadColor, trailingColor: trailColor)
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
            Slider(value: $progress, in: 0.0...5.5, step: 0.01)
            Text(String(format: "%.2f", progress))
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
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
