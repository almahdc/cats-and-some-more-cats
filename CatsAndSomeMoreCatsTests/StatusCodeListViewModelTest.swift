//
//  StatusCodeListViewModelTest.swift
//  CatsAndSomeMoreCatsTests
//
//  Created by Alma Hodzic on 09.01.23.
//

import XCTest

@testable import CatsAndSomeMoreCats

final class StatusCodeListViewModelTest: XCTestCase {
    private var sut: StatusCodeListViewModel!

    override func setUp() {
        super.setUp()
        sut = .init()
        sut.showCatDetails = { _ in }
    }

    // MARK: – sections –

    func testNumberOfSections() {
        XCTAssertEqual(sut.sections.count, HTTPStatusCode.allCases.count)
    }

    func testSectionOneLeftTitleEqualsHTTPStatusCodeSubscriptOneOnDidSelectSectionOne() {
        // when
        sut.didSelect(section: 1)

        // then
        XCTAssertEqual(sut.sections[1].leftTitle, "\(HTTPStatusCode.allCases[1].rawValue)")
    }

    func testSectionOneWasTappedOnDidSelectSectionOne() {
        // when
        sut.didSelect(section: 1)

        // then
        XCTAssertTrue(sut.sections[1].wasTapped.value)
    }

    func testSectionTwoWasNotTappedOnDidSelectSectionOne() {
        // given && when
        sut.showCatDetails = { _ in }
        sut.didSelect(section: 1)

        // then
        XCTAssertFalse(sut.sections[2].wasTapped.value)
    }

    func testSectionOneStaysTappedOnDidSelectSectionOneMultipleTimes() {
        // given && when
        sut.showCatDetails = { _ in }
        sut.didSelect(section: 1)
        sut.didSelect(section: 1)

        // then
        XCTAssertTrue(sut.sections[1].wasTapped.value)
    }

    // MARK: – showCatDetails –

    func testInvokeShowCatDetailsOnDidSelect() {
        // given
        var count = 0
        sut.showCatDetails = { _ in count += 1 }

        // when
        sut.didSelect(section: 1)

        // then
        XCTAssertEqual(count, 1)
    }
}
