//
//  TwoLabelsCell.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class TwoLabelsCell: DisposableObserverableCell {
    var didTapCell: Action!

    private enum Constants {
        static let spacing = 16.0
    }

    // MARK: – Properties –

    var leftLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    // MARK: – Init –
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    private func setUpViews() {
        let stackView = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
