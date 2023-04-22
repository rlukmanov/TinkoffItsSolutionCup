//
//  CollectionViewCell.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = "CollectionViewCell"
    
    // MARK: - Private properties
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

    private var viewModel: HorizontalListViewModel.ElementModel?
    
    // MARK: - Init
    
    init(viewModel: HorizontalListViewModel.ElementModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.backgroundColor = .Background.buttonMain
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        configureSubtitleLabel()
        configureTitleLabel()
    }
    
    // MARK: UI Configuration
    private func configureSubtitleLabel() {
        descriptionLabel = .makeLabel(text: viewModel?.subtitle, font: .systemFont(ofSize: 15, weight: .bold)).prepareForAutoLayout()
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor ~= contentView.leftAnchor + 12
        descriptionLabel.rightAnchor <= contentView.rightAnchor - 12
        descriptionLabel.bottomAnchor ~= contentView.bottomAnchor - 12
    }
    
    private func configureTitleLabel() {
        titleLabel = .makeLabel(text: viewModel?.title, font: .systemFont(ofSize: 15, weight: .bold)).prepareForAutoLayout()
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor ~= contentView.leftAnchor + 12
        titleLabel.rightAnchor <= contentView.rightAnchor - 12
        titleLabel.bottomAnchor ~= descriptionLabel.topAnchor - 4
    }
    
    //MARK: Public properties
    public func updateViewModel(viewModel: HorizontalListViewModel.ElementModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.subtitle
    }
}
