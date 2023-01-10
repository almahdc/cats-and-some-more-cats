//
//  ImageWithLabelItem.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 10.01.23.
//

import UIKit

enum LoadingState {
    case loading
    case loaded(image: UIImage)
    case failure(action: Action)
}

struct ImageWithLabelItem {
    let imageTitle: String
    let loadingState: Bindable<LoadingState>
}

extension ImageWithLabelView {
    func apply(_ item: ImageWithLabelItem) {
        titleLabel.text = item.imageTitle

        item.loadingState.bind(self) { observer, loadingState in
            switch loadingState {
            case .loading:
                observer.activityIndicator.startAnimating()
                observer.activityIndicator.isHidden = false
                observer.button.isHidden = true
                observer.imageView.isHidden = true
            case let .loaded(image):
                observer.imageView.image = image
                observer.activityIndicator.stopAnimating()
                observer.activityIndicator.isHidden = true
                observer.button.isHidden = true
                observer.imageView.isHidden = false
            case let .failure(action):
                observer.button.didTapAction = action
                observer.button.isHidden = false
                observer.imageView.isHidden = true
                observer.activityIndicator.stopAnimating()
                observer.activityIndicator.isHidden = true
            }
        }
    }
}
