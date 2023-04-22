//
//  TinkoffItsButton.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

//MARK: - TinkoffItsButton
public class TinkoffItsButton: UIButton {

    public enum VisualStyle {
        case primary
    }
    
    public enum SizeStyle {
        case standart
    }

    //MARK: UIConstants
    private struct UIConstants {
        static let standartHeight: CGFloat = 44
        static let borderWidth: CGFloat = 0.0
        static let cornerRadius: CGFloat = 12
    }
    
    //MARK: Private properties
    private var heightConstraint: NSLayoutConstraint!
    private var cornerRadius = UIConstants.cornerRadius
    
    private var backgroundColors: [UIControl.State.RawValue: UIColor] = [:]
    private var borderColors: [UIControl.State.RawValue: UIColor] = [:]
    private var textColors: [UIControl.State.RawValue: UIColor] = [:]
    
    private var visualStyle: VisualStyle = .primary
    private var sizeStyle: SizeStyle = .standart
    
    private var preferredHeight: CGFloat {
        switch sizeStyle {
        case .standart:
            return UIConstants.standartHeight
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        updateButtonUI(style: .primary)
        updateButtonSize(style: .standart)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        updateButtonUI(style: .primary)
        updateButtonSize(style: .standart)
    }
    
    public init(visualStyle: VisualStyle, sizeStyle: SizeStyle = .standart, frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
        updateButtonUI(style: visualStyle)
        updateButtonSize(style: sizeStyle)
    }
    
    private func commonInit() {
        layer.cornerRadius = cornerRadius
        heightConstraint = heightAnchor ~= UIConstants.standartHeight
    }
    
    //MARK: Overriding
    public override func layoutSubviews() {
        super.layoutSubviews()
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shadowPath = cgPath
    }
    
    //MARK: UIControl overriding
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.didSetState(.highlighted)
            }
            else {
                self.didSetState(.normal)
            }
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.didSetState(.normal)
            }
            else {
                self.didSetState(.disabled)
            }
        }
    }
    
    //MARK: Public methods
    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        backgroundColors[state.rawValue] = color
        if self.state == state {
            backgroundColor = color
        }
    }
    
    public func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        borderColors[state.rawValue] = color
        if self.state == state {
            layer.borderColor = color?.cgColor
        }
    }
    
    public func setCornerRadius(_ radius: CGFloat) {
        cornerRadius = radius
        layer.cornerRadius = radius
    }
    
    public func updateButtonUI(style: VisualStyle) {
        self.visualStyle = style
        
        switch style {
        case .primary:
            layer.borderWidth = UIConstants.borderWidth
            // Normal
            setBackgroundColor(.Background.buttonMain, for: .normal)
            setTitleColor(.Text.buttonMain, for: .normal)
            // Highlighted
            setBackgroundColor(.Background.buttonHighlighted, for: .highlighted)
            setTitleColor(.Text.buttonMain, for: .highlighted)
        }
    }
    
    public func updateButtonSize(style: SizeStyle) {
        self.sizeStyle = style
        
        switch style {
        case .standart:
            heightConstraint.constant = UIConstants.standartHeight
            titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }

    //MARK: Private methods
    private func didSetState(_ state: UIControl.State) {
        let duration: TimeInterval = state == .normal ? 0.3 : 0.05
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = self.backgroundColors[state.rawValue]
            self.layer.borderColor = self.borderColors[state.rawValue]?.cgColor
        })
    }
}
