//
//  Button.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 10.01.23.
//

import UIKit

final class Button: UIButton {
    var didTapAction: Action? {
        didSet {
            let selector = #selector(didTap)
            let event = UIControl.Event.touchUpInside
            removeTarget(self, action: selector, for: event)
            addTarget(self, action: selector, for: event)
        }
    }

    @objc private func didTap() {
        didTapAction?()
    }
}
