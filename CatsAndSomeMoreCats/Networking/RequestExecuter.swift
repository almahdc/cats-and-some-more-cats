//
//  RequestExecuter.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import Foundation

class RequestExecuter {
    // MARK: – Execute request –

    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.handleResponse(data: data, response: response, error: error, completion: completion)
            }
        }.resume()
    }
    
    // MARK: – Handle response –
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, Error>) -> Void) {
        assert(Thread.isMainThread, "Should always be invoked on the main thread")
        guard response != nil, let data = data else {
            guard let error else {
                fatalError("Error is missing")
            }
            completion(.failure(error))
            return
        }

        completion(.success(data))
    }
}
