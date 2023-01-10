//
//  CatProvider.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import Foundation

enum ImageError: Error {
    case generic
}

protocol CatProviding {
    func cat(statusCode: String, completion: @escaping (Result<Data, ImageError>) -> Void)
}

final class CatProvider: CatProviding {
    // MARK: – Properties –

    private let requestExecuter: RequestExecuter
    
    // MARK: – Init –
    
    init(requestExecuter: RequestExecuter) {
        self.requestExecuter = requestExecuter
    }

    // MARK: – Get Cat with Status Code –
    
    func cat(statusCode: String, completion: @escaping (Result<Data, ImageError>) -> Void) {
        requestExecuter.execute(request: RequestFactory.makeCatRequest(statusCode: statusCode)) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case .failure:
                completion(.failure((.generic)))
            }
        }
    }
}
