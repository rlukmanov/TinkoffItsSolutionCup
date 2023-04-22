//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

//MARK: - CardView
public class CardView: UIView {
    
    struct UIConstants {
        static let cornerRadius: CGFloat = 24
        static let defaultLeftOffset: CGFloat = 20
        static let defaultVerticalOffset: CGFloat = 16
        static let defaultRightOffset: CGFloat = 16
        static let contentStackViewSpacing: CGFloat = 14
        static let titlesStackViewSpacing: CGFloat = 8
        static let horizontalStackViewSpacing: CGFloat = 16
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
    
    var subtitle: String? {
        get {
            subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
            subtitleLabel.isHidden = newValue == nil
        }
    }
    
    var isBottomButtonHidden: Bool {
        get {
            bottomButton.isHidden
        }
        set {
            bottomButton.isHidden = newValue
        }
    }
    
    var bottomButtonTitle: String? {
        get {
            bottomButton.title(for: .normal)
        }
        set {
            bottomButton.setTitle(newValue, for: .normal)
        }
    }
    
    var isLeadingImageViewHidden: Bool {
        get {
            leadingImageView.isHidden
        }
        set {
            leadingImageView.isHidden = newValue
        }
    }
    
    var isTrailingImageViewHidden: Bool {
        get {
            trailingImageView.isHidden
        }
        set {
            trailingImageView.isHidden = newValue
        }
    }
    
    //MARK: Private properties
    private var contentStackView: UIStackView!
    private var horizontalStackView: UIStackView!
    private var titlesStackView: UIStackView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var bottomButton: TinkoffItsButton!
    private var leadingImageView: UIImageView!
    private var trailingImageView: UIImageView!
    
    private var viewModel: CardViewModel?
    
    //MARK: Initializers
    public init(viewModel: CardViewModel) {
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
        configureHorizontalStackView()
        configureTitlesStackView()
        configureTitleLabel()
        configureSubtitleLabel()
        configureBottomButton()
        configureLeadingImageView()
        configureTrailingImageView()
        
        updateViewModel(viewModel: viewModel)
    }
    
    // MARK: UIConfiguration
    private func configureContentStackView() {
        contentStackView = UIStackView().prepareForAutoLayout()
        contentStackView.axis = .vertical
        contentStackView.spacing = UIConstants.contentStackViewSpacing
        addSubview(contentStackView)
        contentStackView.pinEdgesToSuperviewEdges(top: UIConstants.defaultVerticalOffset, left: UIConstants.defaultLeftOffset, bottom: UIConstants.defaultVerticalOffset, right: UIConstants.defaultRightOffset)
    }
    
    private func configureHorizontalStackView() {
        horizontalStackView = UIStackView().prepareForAutoLayout()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = UIConstants.horizontalStackViewSpacing
        contentStackView.addArrangedSubview(horizontalStackView)
    }
    
    private func configureTitlesStackView() {
        titlesStackView = UIStackView().prepareForAutoLayout()
        titlesStackView.axis = .vertical
        titlesStackView.spacing = UIConstants.titlesStackViewSpacing
        horizontalStackView.addArrangedSubview(titlesStackView)
    }
    
    private func configureTitleLabel() {
        titleLabel = .makeLabel(font: .systemFont(ofSize: 20, weight: .bold)).prepareForAutoLayout()
        titlesStackView.addArrangedSubview(titleLabel)
    }
    
    private func configureSubtitleLabel() {
        subtitleLabel = .makeLabel(font: .systemFont(ofSize: 15, weight: .regular), textColor: .Text.subhead).prepareForAutoLayout()
        titlesStackView.addArrangedSubview(subtitleLabel)
    }
    
    private func configureBottomButton() {
        bottomButton = TinkoffItsButton(visualStyle: .primary).prepareForAutoLayout()
        contentStackView.addArrangedSubview(bottomButton)
    }
    
    private func configureLeadingImageView() {
        leadingImageView = UIImageView(image: .Common.avatarIcon).prepareForAutoLayout()
        leadingImageView.setContentHuggingPriority(.required, for: .horizontal)
        leadingImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        horizontalStackView.addArrangedSubview(leadingImageView)
    }
    
    private func configureTrailingImageView() {
        trailingImageView = UIImageView(image: .Common.avatarIcon).prepareForAutoLayout()
        trailingImageView.setContentHuggingPriority(.required, for: .horizontal)
        trailingImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        horizontalStackView.addArrangedSubview(trailingImageView)
    }
    
    //MARK: Public methods
    public func updateViewModel(viewModel: CardViewModel?) {
        self.viewModel = viewModel
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        subtitleLabel.isHidden = viewModel.subtitle == nil
        
        if let bottomButtonModel = viewModel.bottomButton {
            bottomButton.setTitle(bottomButtonModel.title, for: .normal)
            bottomButton.addAction(bottomButtonModel.action, forControlEvents: .touchUpInside)
        }
        bottomButton.isHidden = viewModel.bottomButton == nil
        
        if let imageSide = viewModel.imageSide {
            switch imageSide {
            case .left:
                leadingImageView.isHidden = false
                trailingImageView.isHidden = true
            case .right:
                leadingImageView.isHidden = true
                trailingImageView.isHidden = false
            case .none:
                leadingImageView.isHidden = true
                trailingImageView.isHidden = true
            }
        } else {
            leadingImageView.isHidden = true
            trailingImageView.isHidden = true
        }
    }
}
