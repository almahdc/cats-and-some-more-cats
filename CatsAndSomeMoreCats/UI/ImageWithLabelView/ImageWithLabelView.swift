//
//  ImageWithLabelView.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

class ImageWithLabelView: UIView {
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
        let view = UIImageView()
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        return button
    }()


    // MARK: – Init –

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    private func setUpViews() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, activityIndicator, imageView, button])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        let stackViewConstraints = [
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, constant: -32)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
