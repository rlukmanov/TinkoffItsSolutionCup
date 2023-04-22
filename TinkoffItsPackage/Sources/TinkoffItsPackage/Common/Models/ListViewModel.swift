//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import Foundation

//MARK: - ListViewModel
public struct ListViewModel {
    
    public struct ButtonModel {
        let title: String?
        let action: Action
        
        public init(title: String?, action: @escaping Action) {
            self.title = title
            self.action = action
        }
    }
    
    let title: String?
    let trailngButton: ButtonModel?
    let elements: [CardViewModel]
    let bottomButton: ButtonModel?
    
    public init(title: String?, trailngButton: ButtonModel?, elements: [CardViewModel], bottomButton: ButtonModel?) {
        self.title = title
        self.trailngButton = trailngButton
        self.elements = elements
        self.bottomButton = bottomButton
    }
}
