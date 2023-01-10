//
//  ImageWithLabelView.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class ImageWithLabelView: UIView {
    private enum Constants {
        static let spacing = 16.0
    }

    // MARK: – Properties –

    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let activityIndicator = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let button: Button = {
        let button = Button()
        button.setTitle("Try again, please", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)

        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()

    // MARK: – Init –

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: – Set up views –

    private func setUpViews() {
        backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [titleLabel, activityIndicator, imageView, button])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        let stackViewConstraints = [
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            stackView.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, constant: -2*Constants.spacing)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }
}
