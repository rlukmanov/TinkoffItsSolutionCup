//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

//MARK: - HorizontalListView
public struct HorizontalListViewModel {
    
    public struct ButtonModel {
        let title: String?
        let action: Action
        
        public init(title: String?, action: @escaping Action) {
            self.title = title
            self.action = action
        }
    }
    
    public struct ElementModel {
        let title: String?
        let subtitle: String?
        let image: UIImage?
    }
    
    let title: String?
    let trailngButton: ButtonModel?
    let elements: [ElementModel]
    let bottomButton: ButtonModel?
    
    public init(title: String?, trailngButton: ButtonModel?, elements: [ElementModel], bottomButton: ButtonModel? = nil) {
        self.title = title
        self.trailngButton = trailngButton
        self.elements = elements
        self.bottomButton = bottomButton
    }
}
