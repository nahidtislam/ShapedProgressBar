//
//  SettingsData.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 01/06/2023.
//

import Foundation

struct SettingsData: Codable {
    
    var leadColor: String
    var trailColor: String
    var outlineColor: String?
    
    var useSlider: Bool
    var maxValue: Double
    
    var allowOtherShape: Bool
}

extension SettingsData: RawRepresentable {
    static let base = SettingsData(leadColor: "#5ac4bd", trailColor: "#3478f6", outlineColor: "#59abe121", useSlider: true, maxValue: 5.5, allowOtherShape: false)
    
    var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let str = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return str
    }

    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else { return nil }

        if let v = try? JSONDecoder().decode(SettingsData.self, from: data) {
            self = v
        } else {
            return nil
        }
    }
}
