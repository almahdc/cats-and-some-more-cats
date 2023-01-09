//
//  RequestFactory.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import Foundation

struct RequestFactory {
    private enum API {
        static let cat = "https://http.cat/"
    }

    // MARK: – Cat request –

    static func makeCatRequest(statusCode: String) -> URLRequest {
        guard let url = makeGetCatURL(endpoint: statusCode) else {
            fatalError("Invalid url")
        }

        return URLRequest(url: url)
    }
    
    private static func makeGetCatURL(endpoint: String) -> URL? {
        let url = URL(string: API.cat + endpoint)
        return url
    }
}
