//
//  ViewController.swift
//  TinkofItsSulutionCup
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit
import TinkoffItsPackage

//MARK: - ViewController
class ViewController: UIViewController {
    
    private struct Texts {
        static let defaultHeader: String = "Header"
        static let defaultSubtitle: String = "Subheader"
        static let buttonTitle: String = "Button"
    }
    
    //MARK: UI Properies
    private var contentStackView: UIStackView = {
        let view = UIStackView().prepareForAutoLayout()
        view.axis = .vertical
        view.spacing = 40
        return view
    }()
    
    private lazy var cardOneView: CardView = {
        let viewModel = CardViewModel(title: Texts.defaultHeader, subtitle: Texts.defaultSubtitle, imageSide: .right)
        let view = CardView(viewModel: viewModel).prepareForAutoLayout()
        return view
    }()
    
    private lazy var cardTwoView: CardView = {
        let viewModel = CardViewModel(title: Texts.defaultHeader, imageSide: .right)
        let view = CardView(viewModel: viewModel).prepareForAutoLayout()
        return view
    }()
    
    private lazy var cardThreeView: CardView = {
        let bottomButtonViewModel = CardViewModel.BottomButtonModel(title: Texts.buttonTitle, action: { _ in
            print("cardThreeViewButtonTapped")
        })
        let viewModel = CardViewModel(title: Texts.defaultHeader, subtitle: Texts.defaultSubtitle, bottomButton: bottomButtonViewModel, imageSide: .right)
        let view = CardView(viewModel: viewModel).prepareForAutoLayout()
        return view
    }()
    
    private lazy var strechView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#f8d81c")

        view.addSubview(contentStackView)
        contentStackView.leftAnchor ~= view.leftAnchor + 16
        contentStackView.rightAnchor ~= view.rightAnchor - 16
        contentStackView.topAnchor ~= view.safeAreaLayoutGuide.topAnchor
        contentStackView.bottomAnchor ~= view.safeAreaLayoutGuide.bottomAnchor
        
        contentStackView.addArrangedSubview(cardOneView)
        contentStackView.addArrangedSubview(cardTwoView)
        contentStackView.addArrangedSubview(cardThreeView)
        
        contentStackView.addArrangedSubview(strechView)
    }
}

