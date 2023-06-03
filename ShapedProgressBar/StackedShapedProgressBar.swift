//
//  StackedShapedProgressBar.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 02/06/2023.
//

import SwiftUI

struct StackedShapedProgressBar<BaseShape: InsettableShape>: View {
    let pieces: [Piece]
    let thickness: CGFloat
    @ViewBuilder var base: () -> BaseShape
    
    var body: some View {
        ZStack {
            ForEach(pieces) { piece in
                let index = pieces.index(using: piece)
                let insetValue = Double(index) * thickness * 1.05
                ring(color: piece.ringColor, inset: insetValue, value: piece.value)
            }
        }
    }
    
    func ring(color: ShapedProgressBar<BaseShape>.RingColor, inset: Double, value: Double) -> ShapedProgressBar<BaseShape> {
        ShapedProgressBar(
            base().inset(by: inset) as! BaseShape,
            value: value,
            thickness: thickness,
            ringColor: color
        )
    }
}

struct StackedShapedProgressBar_Previews: PreviewProvider {
    private static let pieces: [StackedShapedProgressBar<Circle>.Piece] = [
        .init(value: 0.3, ringColor: .init(leading: .blue, trailing: .mint)),
        .init(value: 0.8, ringColor: .init(leading: .red, trailing: .mint)),
        .init(value: 0.2, ringColor: .init(leading: .blue, trailing: .yellow)),
        .init(value: 0.9, ringColor: .init(leading: .cyan, trailing: .yellow)),
        ]
    
    static var previews: some View {
        StackedShapedProgressBar(pieces: Self.pieces, thickness: 24) {
            Circle()
        }
    }
}
