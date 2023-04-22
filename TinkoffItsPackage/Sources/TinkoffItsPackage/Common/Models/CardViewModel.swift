//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

public typealias Action = (UIControl) -> ()

//MARK: - CardViewModel
public struct CardViewModel {
    
    public struct BottomButtonModel {
        let title: String?
        let action: Action
        
        public init(title: String?, action: @escaping Action) {
            self.title = title
            self.action = action
        }
    }
    
    public enum ImageSide {
        case left
        case right
        case none
    }
    
    let title: String?
    let subtitle: String?
    let bottomButton: BottomButtonModel?
    let imageSide: ImageSide?
    let insets: UIEdgeInsets
    
    public init(title: String?, subtitle: String? = nil, bottomButton: BottomButtonModel? = nil, imageSide: ImageSide? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 20, right: 16)) {
        self.title = title
        self.subtitle = subtitle
        self.bottomButton = bottomButton
        self.imageSide = imageSide
        self.insets = insets
    }
}
