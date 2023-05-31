//
//  ShapedProgressBar.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 29/05/2023.
//

import SwiftUI

struct ShapedProgressBar<BaseShape: Shape>: View {
    
    var value: CGFloat
    let thickness: CGFloat
    
    @ViewBuilder var base: () -> BaseShape
    
    @Environment(\.layoutDirection) var layoutDirection
    
    private var leadingColor: Color
    private var trailingColor: Color
    private var outlinedColor: Color?
    
    init(value: CGFloat, thickness: CGFloat, leadingColor: Color, trailingColor: Color, outlinedColor: Color? = nil, base: @escaping () -> BaseShape) {
        self.value = value
        self.thickness = thickness
        self.base = base
        self.leadingColor = leadingColor
        self.trailingColor = trailingColor
        self.outlinedColor = outlinedColor
    }
    
    var body: some View {
        ZStack {
            if let outlinedColor {
                base()
                    .stroke(lineWidth: thickness)
                    .foregroundColor(outlinedColor)
            }
            drawn
        }
//        .aspectRatio(1, contentMode: .fit)
        .padding(thickness / 2)
        .rotationEffect(.radians(.pi / -2))
        .rotationEffect(layoutDirection == .rightToLeft ? .radians(.pi) : .zero)
    }
    
    
    private var drawn: some View {
        ZStack {
            arc
            if value == 0 { initalTip }
            cycledTip
                .opacity(value > 0.85 ? 1 : 0)
        }
    }
    private var arc: some View {
        base()
            .trim(from: 0, to: value)
            .stroke(aGrad, style: sStyle)
    }
    
    private var aGrad: AngularGradient {
//        .init(
//            gradient: Gradient(colors: [trailingColor, leadingColor]),
//            center: .center,
//            angle: progressAngle
//        )
        .init(
            colors: [trailingColor, leadingColor],
            center: .center,
            startAngle: apropiateStartAngle,
            endAngle: value > 0.1 ? progressAngle : .radians(2 * .pi * 0.1)
        )
    }
    
    private var apropiateStartAngle: Angle {
        value < 2 ? .radians(0) : .radians(2 * .pi * (value - .pi))
    }
    
    private var sStyle: StrokeStyle {
        .init(lineWidth: thickness, lineCap: .round)
    }
    
    private var progressAngle: Angle {
        .radians(value * 2 * .pi)
    }
    
    private var initalTip: some View {
        base()
            .trim(from: 0, to: 0.0001)
            .stroke(style: sStyle)
            .foregroundColor(trailingColor)
//            .mask {
//                LinearGradient(
//                    colors: [
//                        .black,
//                        .white.opacity(0.0),
//                        .white.opacity(0)],
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//            }
    }
    
    private var cycledTip: some View {
        //TODO: make it work with other shapes other than `Circle`
        base()
            .trim(from: 0, to: 0.0001)
            .stroke(style: sStyle)
            .foregroundColor(leadingColor)
//            .transition(.asymmetric(insertion: .opacity.animation(.linear.speed(value)), removal: .opacity.animation(.none)))
            .shadow(color: .black, radius: 12)
            .mask {
                base()
                    .trim(from: 0, to: 0.5)
                    .stroke(style: sStyle)
            }
            .rotationEffect(progressAngle)
    }
}

struct ShapedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ShapedProgressBar(value: 1, shape: Circle(), thickness: 66)
        ShapedProgressBar(Rectangle(), value: 0.95, thickness: 48, leadingColor: .mint, trailingColor: .cyan)
            .aspectRatio(1, contentMode: .fit)
    }
}

extension ShapedProgressBar {
    init(value: CGFloat, shape: BaseShape, thickness: CGFloat = 18) {
        self.value = value
        self.thickness = thickness

        self.base = { shape }

        self.leadingColor = .init(.displayP3, red: 0.15, green: 0.7, blue: 1)
        self.trailingColor = .init(.displayP3, red: 0, green: 0.4, blue: 0.85)
    }
    
    init(_ base: BaseShape, value: CGFloat, thickness: CGFloat, leadingColor: Color, trailingColor: Color, outlinedColor: Color? = nil) {
        self.value = value
        self.thickness = thickness
        self.base = { base }
        self.leadingColor = leadingColor
        self.trailingColor = trailingColor
        self.outlinedColor = outlinedColor
    }
}
