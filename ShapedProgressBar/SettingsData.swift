//
//  SettingsData.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 01/06/2023.
//

import Foundation

struct SettingsData: Codable {
    let leadColor: String
    let trailColor: String
    let outlineColor: String?
    
    let useSlider: Bool
    let maxValue: Double
    
    let allowOtherShape: Bool
}
