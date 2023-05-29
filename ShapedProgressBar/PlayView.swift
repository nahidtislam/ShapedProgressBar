//
//  PlayView.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 29/05/2023.
//

import SwiftUI

struct PlayView: View {
    
    @State private var progess = 0.7
    @State private var useSlider = true
    
    let shapes: [(any Shape, UUID)] = [(Circle(), UUID()), (Rectangle(), UUID()), (RoundedRectangle(cornerRadius: 30), UUID())]
    
    var body: some View {
        VStack {
            Label("hello world!", systemImage: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            TabView {
                ShapedProgressBar(value: progess, shape: Circle(), thickness: 48)
                    .padding()
                ShapedProgressBar(value: progess, shape: Rectangle(), thickness: 48)
                    .padding()
                ShapedProgressBar(value: progess, shape: RoundedRectangle(cornerRadius: 30), thickness: 48)
                    .padding()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.default, value: progess)
                .frame(width: 280, height: 280)
            if useSlider {
                slider
            } else {
                incrementingButtons
            }
        }
        .padding()
    }
    
    private var incrementingButtons: some View {
        HStack {
            Button {
                guard progess > 0 else { return }
                progess -= 0.05
            } label: {
                Label("reduce", image: "minus.square")
            }
            Text(String(format: "%.2f", progess))
            Button {
                progess += 0.05
            } label: {
                Label("increase", image: "plus.square.fill")
            }
        }
    }
    
    private var slider: some View {
        HStack {
            Text("progress")
            Slider(value: $progess, in: 0.0...5.5, step: 0.01)
            Text(String(format: "%.2f", progess))
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
