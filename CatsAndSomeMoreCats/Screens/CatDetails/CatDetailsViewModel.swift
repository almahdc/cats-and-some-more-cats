//
//  CatDetailsViewModel.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class CatDetailsViewModel {
    // MARK: – Actions –
    
    var didFail: Action1<String>!

    // MARK: – Properties –

    lazy var imageWithLabelItem: ImageWithLabelItem = {
        let imageWithLabelItem = ImageWithLabelItem(
            imageTitle: statusCode,
            loadingState: .init(value: .loading)
        )
        return imageWithLabelItem
    }()

    private var statusCode: String
    private let catProvider: CatProviding
    
    // MARK: – Init –
    
    init(statusCode: String, catProvider: CatProviding) {
        self.statusCode = statusCode
        self.catProvider = catProvider
    }

    // MARK: – Start –
    
    func start() {
        requestCat(statusCode: statusCode)
    }
    
    // MARK: – Network requests –
    
    private func requestCat(statusCode: String) {
        imageWithLabelItem.loadingState.value = .loading
        catProvider.cat(statusCode: statusCode) { [weak self] result in
            switch result {
            case let .success(imageData):
                guard let image = UIImage.init(data: imageData) else {
                    self?.handleFailure()
                    return
                }
                self?.imageWithLabelItem.loadingState.value = .loaded(image: image)
            case .failure:
                self?.handleFailure()
            }
        }
    }
    
    private func handleFailure() {
        imageWithLabelItem.loadingState.value = .failure(action: { [unowned self] in requestCat(statusCode: statusCode) })
        didFail("Sorry, the data can't be shown at the moment.")
    }
}
