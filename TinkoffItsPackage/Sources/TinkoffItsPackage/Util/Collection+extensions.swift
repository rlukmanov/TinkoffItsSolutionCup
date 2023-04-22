//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
