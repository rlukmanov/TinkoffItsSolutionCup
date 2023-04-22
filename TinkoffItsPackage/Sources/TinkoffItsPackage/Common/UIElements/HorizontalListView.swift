//
//  File.swift
//  
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit

//MARK: - HorizontalListView
final public class HorizontalListView: UIView {
    
    struct UIConstants {
        static let cornerRadius: CGFloat = 24
        static let contentStackViewSpacing: CGFloat = .zero
        static let defaultHorizontalOffset: CGFloat = 20
        static let defaultVerticalOffset: CGFloat = 16
        static let collectionViewElementsSize: CGFloat = 140
    }

    //MARK: Private properties
    private var topView: UIView!
    private var contentStackView: UIStackView!
    
    private var titleLabel: UILabel!
    private var trailingButton: UIButton!
    private var collectionView: UICollectionView!
    private var bottomButton: TinkoffItsButton!
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIConstants.collectionViewElementsSize, height: UIConstants.collectionViewElementsSize)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20)
        return layout
    }()
    
    private var viewModel: HorizontalListViewModel?
    
    //MARK: Initializers
    public init(viewModel: HorizontalListViewModel) {
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
        configureCollectionView()
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
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).prepareForAutoLayout()
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.clipsToBounds = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentStackView.addArrangedSubview(collectionView)
        collectionView.heightAnchor ~= UIConstants.collectionViewElementsSize
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
        trailingButton.rightAnchor ~= topView.rightAnchor
        trailingButton.centerYAnchor ~= titleLabel.centerYAnchor
    }
    
    private func configureBottomButton() {
        bottomButton = TinkoffItsButton(visualStyle: .primary).prepareForAutoLayout()
        contentStackView.addArrangedSubview(bottomButton)
    }
    
    //MARK: Public methods
    public func updateViewModel(viewModel: HorizontalListViewModel?) {
        self.viewModel = viewModel
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        trailingButton.setTitle(viewModel.trailngButton?.title, for: .normal)
        if let trailingButtonVM = viewModel.trailngButton {
            trailingButton.addAction(trailingButtonVM.action, forControlEvents: .touchUpInside)
        }

        collectionView.reloadData()
        
        if let bottomButtonModel = viewModel.bottomButton {
            bottomButton.setTitle(bottomButtonModel.title, for: .normal)
            bottomButton.addAction(bottomButtonModel.action, forControlEvents: .touchUpInside)
        }
        bottomButton.isHidden = viewModel.bottomButton == nil
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HorizontalListView: UICollectionViewDataSource & UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.elements.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell, let viewModel = viewModel?.elements[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.updateViewModel(viewModel: viewModel)
        return cell
    }
}
