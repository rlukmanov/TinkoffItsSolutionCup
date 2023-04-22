//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

public extension UIColor {
    
    fileprivate struct HEX {
        static let hFFFFFF = UIColor(hex: 0xFFFFFF)
        static let h333333 = UIColor(hex: 0x333333)
        static let h9299A2 = UIColor(hex: 0x9299A2)
        static let h428BF9 = UIColor(hex: 0x428BF9)
        static let h001024 = UIColor(hex: 0x001024)
    }
    
    struct Background {
        /// #FFFFFF
        static var primary: UIColor { HEX.hFFFFFF }
        /// #001024.withAlphaComponent(0.03)
        static var buttonMain: UIColor { HEX.h001024.withAlphaComponent(0.03) }
        /// #001024.withAlphaComponent(0.06)
        static var buttonHighlighted: UIColor { HEX.h001024.withAlphaComponent(0.06) }
    }
    
    struct Text {
        /// #333333
        static var primary: UIColor { HEX.h333333 }
        /// #9299A2
        static var subhead: UIColor { HEX.h9299A2 }
        /// #428BF9
        static var buttonMain: UIColor { HEX.h428BF9 }
    }
    
    /// Returns nil if cgColor.components are nil or its count less that 3
    var hexString: String? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
    }
    
    //MARK: Inits
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(hex hexValue: Int64) {
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
