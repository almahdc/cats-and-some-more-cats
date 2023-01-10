//
//  CatDetailsViewModelTest.swift
//  CatsAndSomeMoreCatsTests
//
//  Created by Alma Hodzic on 10.01.23.
//

import XCTest

@testable import CatsAndSomeMoreCats

final class CatDetailsViewModelTest: XCTestCase {
    private var sut: CatDetailsViewModel!
    private var catProvider: DummyCatProvider!
    
    override func setUp() {
        super.setUp()
        catProvider = DummyCatProvider()
        sut = .init(statusCode: "", catProvider: catProvider)
        sut.didFail = { _ in }
    }
    
    func testDoesNotInvokeRequestInitially() {
        XCTAssertFalse(catProvider.invokedCat)
    }
    
    // MARK: – Start –
    
    func testInvokesRequestOnStart() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(catProvider.invokedCat)
    }
    
    // MARK: – Item –
    
    func testLoadingStateIsLoadingOnStart() {
        // given
        sut.start()
        
        // then
        guard case .loading = sut.imageWithLabelItem.loadingState.value else {
            fatalError("Expected loading loading state")
        }
    }
    
    func testLoadingStateIsLoadedOnRequestSuccess() {
        // given
        catProvider.stubbedCatCompletionResult = (.success(StubModel.imageData), ())
        
        // when
        sut.start()
        
        // then
        guard case .loaded = sut.imageWithLabelItem.loadingState.value else {
            fatalError("Expected loaded loading state")
        }
    }
    
    func testLoadingStateIsFailedOnRequestFailure() {
        // given
        catProvider.stubbedCatCompletionResult = (.failure(.generic), ())
        
        // when
        sut.start()
        
        // then
        guard case .failure = sut.imageWithLabelItem.loadingState.value else {
            fatalError("Expected failure loading state")
        }
    }
    
    func testImageTitleEqualsStatusCode() {
        // given
        let statusCode = "301"
        sut = .init(statusCode: statusCode, catProvider: catProvider)

        // when
        sut.start()
        
        // then
        XCTAssertEqual(sut.imageWithLabelItem.imageTitle, statusCode)
    }
    
    // MARK: – Network request –
    
    func testInvokesDidFailOnRequestFailure() {
        catProvider.stubbedCatCompletionResult = (.failure(.generic), ())
        var count = 0
        sut.didFail = { _ in count += 1}
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(count, 1)
    }
    
    func testInvokesDidFailOnImageDataConversionFailure() {
        catProvider.stubbedCatCompletionResult = (.success(Data()), ())
        var count = 0
        sut.didFail = { _ in count += 1}
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(count, 1)
    }
    
    func testDoesNotInvokeDidFilaOnRequestSuccess() {
        // given
        catProvider.stubbedCatCompletionResult = (.success(StubModel.imageData), ())
        var count = 0
        sut.didFail = { _ in count += 1}
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(count, 0)
    }

}

// MARK: – DummyCatProvider –

private final class DummyCatProvider: CatProviding {
    var invokedCat = false
    var stubbedCatCompletionResult: (Result<Data,  CatsAndSomeMoreCats.ImageError>, Void)?

    func cat(statusCode: String, completion: @escaping (Result<Data, CatsAndSomeMoreCats.ImageError>) -> Void) {
        invokedCat = true
        if let result = stubbedCatCompletionResult {
            completion(result.0)
        }
    }
}

// MARK: – StubModel –

private enum StubModel {
    static var imageData = image.pngData()!

    private static var image: UIImage = {
        let imageData = Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD5Ip3+AAAADUlEQVQIHWP4v5ThPwAG7wKkSFotfwAAAABJRU5ErkJggg==")
        return .init(data: imageData!)!
    }()
}
