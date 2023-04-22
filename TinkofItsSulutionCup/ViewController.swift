//
//  ViewController.swift
//  TinkofItsSulutionCup
//
//  Created by Ruslan Lukmanov on 22.04.2023.
//

import UIKit
import TinkoffItsPackage

class ViewController: UIViewController {
    
    private lazy var bottomButton: TinkoffItsButton = {
        let button = TinkoffItsButton(visualStyle: .primary).prepareForAutoLayout()
        button.setTitle("Title", for: .normal)
        button.addAction({ [weak self] _ in
            print("bottomButtonTapped")
        }, forControlEvents: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(bottomButton)
        bottomButton.centerXAnchor ~= view.centerXAnchor
        bottomButton.centerYAnchor ~= view.centerYAnchor
        bottomButton.leftAnchor ~= view.leftAnchor + 16
        bottomButton.rightAnchor ~= view.rightAnchor - 16
        
    }


}

