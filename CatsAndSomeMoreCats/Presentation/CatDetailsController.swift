//
//  CatDetailsController.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

class CatDetailsController: UIViewController {
    // MARK: – Properties –

    private var imageWithLabelView = ImageWithLabelView()

    private let viewModel: CatDetailsViewModel

    // MARK: – Init –

    private init(viewModel: CatDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Lifecycle methods –

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    // MARK: – Set up views –
    
    private func setUpView() {
        imageWithLabelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageWithLabelView)
        
        let viewConstraints = [
            imageWithLabelView.topAnchor.constraint(equalTo: view.topAnchor),
            imageWithLabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageWithLabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageWithLabelView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
    }
}

// MARK: – Make –

extension CatDetailsController {
    static func make() -> UIViewController {
        CatDetailsController(viewModel: .init())
    }
}
