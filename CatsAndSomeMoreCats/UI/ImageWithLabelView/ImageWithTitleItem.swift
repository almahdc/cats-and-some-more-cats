//
//  ImageWithTitleItem.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 10.01.23.
//

import UIKit

enum ImageLoadingState {
    case loading
    case loaded(image: UIImage)
    case failed(action: Action)
}

struct ImageWithTitleItem {
    let title: String
    let imageLoadingState: Bindable<ImageLoadingState>
}

extension ImageWithLabelView {
    func apply(_ item: ImageWithTitleItem) {
        titleLabel.text = item.title

        item.imageLoadingState.bind(self) { observer, loadingState in
            switch loadingState {
            case .loading:
                observer.activityIndicator.startAnimating()
                observer.activityIndicator.isHidden = false
                observer.image = nil
                observer.button.isHidden = true
            case let .loaded(image):
                observer.activityIndicator.stopAnimating()
                observer.activityIndicator.isHidden = true
                observer.image = image
                observer.button.isHidden = true
            case let .failed(action):
                observer.activityIndicator.stopAnimating()
                observer.activityIndicator.isHidden = true
                observer.image = nil
                observer.button.didTapAction = action
                observer.button.isHidden = false
            }
        }
    }
}
