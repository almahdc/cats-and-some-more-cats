//
//  CatDetailsController.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class CatDetailsController: UIViewController {
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

        bindViewModel()
        setUpView()

        viewModel.start()
    }

    // MARK: – Bind view model –

    private func bindViewModel() {
        viewModel.didFail = { [unowned self] message in
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }

    // MARK: – Set up views –

    private func setUpView() {
        imageWithLabelView.apply(viewModel.imageWithLabelItem)
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
    static func make(statusCode: String) -> UIViewController {
        CatDetailsController(viewModel: .init(statusCode: statusCode, catProvider: .init(requestExecuter: .init())))
    }
}
