//
//  StackedShapedProgressBar+Piece.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 02/06/2023.
//

import Foundation

extension StackedShapedProgressBar {
    struct Piece: Identifiable {
        let id = UUID()
        let value: Double
        let ringColor: ShapedProgressBar<BaseShape>.RingColor
    }
}
