//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

extension UILabel {
    
    static func makeLabel(text: String? = nil, font: UIFont, textColor: UIColor = .Text.primary, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        return label
    }
}
