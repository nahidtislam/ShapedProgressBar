//
//  SettingsData.swift
//  ShapedProgressBar
//
//  Created by Nahid Islam on 01/06/2023.
//

import SwiftUI

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
        "\(leadColor),\(trailColor),\(outlineColor ?? "nil"),\(useSlider),\(maxValue),\(allowOtherShape)"
        
        /*   using json encoder craashes for some reason
        guard let data = try? JSONEncoder().encode(self),
              let str = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return str
         */
    }

    init?(rawValue: String) {
        let values = rawValue.components(separatedBy: ",")
        guard values.count == 6 else { return nil }
        
        guard let useSlider = Bool(values[3]),
                let maxValue = Double(values[4]),
                let allowOtherShape = Bool(values[5])
        else {
            return nil
        }
        
        self.leadColor = values[0]
        self.trailColor = values[1]
        self.outlineColor = values[2] != "nil" ? values[2] : nil
        self.useSlider = useSlider
        self.maxValue = maxValue
        self.allowOtherShape = allowOtherShape
        
        /*
        guard let data = rawValue.data(using: .utf8) else { return nil }

        if let v = try? JSONDecoder().decode(SettingsData.self, from: data) {
            self = v
        } else {
            return nil
        }
         */
    }
    
}
