//
//  CatProvider.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import UIKit

final class CatProvider {
    enum ImageError: Error {
        case badData
        case generic(error: Error)
    }

    // MARK: – Properties –

    private let requestExecuter: RequestExecuter
    
    // MARK: – Init –
    
    init(requestExecuter: RequestExecuter) {
        self.requestExecuter = requestExecuter
    }

    // MARK: – Get Cat with Status Code –
    
    func cat(statusCode: String, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        requestExecuter.execute(request: RequestFactory.makeCatRequest(statusCode: statusCode)) { result in
            switch result {
            case let .success(data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(ImageError.badData))
                    return
                }
                completion(.success(image))
            case let .failure(error):
                completion(.failure((.generic(error: error))))
            }
        }
    }
}
