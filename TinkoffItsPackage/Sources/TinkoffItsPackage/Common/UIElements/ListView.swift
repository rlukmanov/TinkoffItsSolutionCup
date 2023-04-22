//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

//MARK: - ListView
final public class ListView: UIView {
    
    struct UIConstants {
        static let cornerRadius: CGFloat = 24
        static let contentStackViewSpacing: CGFloat = 20
        static let defaultHorizontalOffset: CGFloat = 20
        static let defaultVerticalOffset: CGFloat = 16
    }
    
    //MARK: Public properties
    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    //MARK: Private properties
    private var topView: UIView!
    private var contentStackView: UIStackView!
    
    private var titleLabel: UILabel!
    private var trailingButton: UIButton!
    private var bottomButton: TinkoffItsButton!
    
    private var viewModel: ListViewModel?
    
    //MARK: Initializers
    public init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .Background.primary
        layer.cornerRadius = UIConstants.cornerRadius
        clipsToBounds = true
        
        configureContentStackView()
        configureTopView()
        configureTitleLabel()
        configureTrailingButton()
        configureBottomButton()
        
        updateViewModel(viewModel: viewModel)
    }
    
    // MARK: UIConfiguration
    private func configureContentStackView() {
        contentStackView = UIStackView().prepareForAutoLayout()
        contentStackView.axis = .vertical
        contentStackView.spacing = UIConstants.contentStackViewSpacing
        addSubview(contentStackView)
        contentStackView.pinEdgesToSuperviewEdges(top: UIConstants.defaultVerticalOffset, left: UIConstants.defaultHorizontalOffset, bottom: UIConstants.defaultHorizontalOffset, right: UIConstants.defaultHorizontalOffset)
    }
    
    private func configureTopView() {
        topView = UIView().prepareForAutoLayout()
        topView.backgroundColor = .clear
        contentStackView.addArrangedSubview(topView)
    }
    
    private func configureTitleLabel() {
        titleLabel = .makeLabel(font: .systemFont(ofSize: 20, weight: .bold)).prepareForAutoLayout()
        topView.addSubview(titleLabel)
        titleLabel.pinToSuperview([.left, .bottom, .top])
    }
    
    private func configureTrailingButton() {
        trailingButton = UIButton(type: .system).prepareForAutoLayout()
        trailingButton.setTitleColor(.Text.buttonMain, for: .normal)
        topView.addSubview(trailingButton)
        trailingButton.leftAnchor >= titleLabel.rightAnchor
        trailingButton.pinToSuperview([.right, .top, .bottom])
    }
    
    private func configureBottomButton() {
        bottomButton = TinkoffItsButton(visualStyle: .primary).prepareForAutoLayout()
        contentStackView.addArrangedSubview(bottomButton)
    }
    
    //MARK: Public methods
    public func updateViewModel(viewModel: ListViewModel?) {
        self.viewModel = viewModel
        for views in contentStackView.arrangedSubviews {
            contentStackView.removeArrangedSubview(views)
        }
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        trailingButton.setTitle(viewModel.trailngButton?.title, for: .normal)
        if let trailingButtonVM = viewModel.trailngButton {
            trailingButton.addAction(trailingButtonVM.action, forControlEvents: .touchUpInside)
        }
        
        for elements in viewModel.elements {
            let view = CardView(viewModel: elements).prepareForAutoLayout()
            contentStackView.addArrangedSubview(view)
        }
        
        if let bottomButtonModel = viewModel.bottomButton {
            bottomButton.setTitle(bottomButtonModel.title, for: .normal)
            bottomButton.addAction(bottomButtonModel.action, forControlEvents: .touchUpInside)
        }
        bottomButton.isHidden = viewModel.bottomButton == nil
        
        layoutIfNeeded()
    }
}
