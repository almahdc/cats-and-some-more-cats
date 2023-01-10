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

    func testSectionZeroWasNotTappedInitially() {
        XCTAssertFalse(sut.sections[0].wasTapped.value)
    }

    func testSectionZeroLeftTitleEqualsHTTPStatusCodeSubscriptOneOnDidSelectSectionZero() {
        // when
        sut.didSelect(section: 0)

        // then
        XCTAssertEqual(sut.sections[0].leftTitle, "\(HTTPStatusCode.allCases[0].rawValue)")
    }

    func testSectionZeroWasTappedOnDidSelectSectionZero() {
        // when
        sut.didSelect(section: 0)

        // then
        XCTAssertTrue(sut.sections[0].wasTapped.value)
    }

    func testSectionZeroStaysTappedOnDidSelectSectionZeroMultipleTimes() {
        // given && when
        sut.showCatDetails = { _ in }
        sut.didSelect(section: 0)
        sut.didSelect(section: 0)

        // then
        XCTAssertTrue(sut.sections[0].wasTapped.value)
    }

    func testTappedSectionGetsInsertedOnPositionZero() {
        // when
        sut.didSelect(section: 10)

        // then
        XCTAssertTrue(sut.sections[0].wasTapped.value)
        XCTAssertFalse(sut.sections[10].wasTapped.value)
    }

    // MARK: – showCatDetails –

    func testInvokeShowCatDetailsOnDidSelect() {
        // given
        var count = 0
        sut.showCatDetails = { _ in count += 1 }

        // when
        sut.didSelect(section: 0)

        // then
        XCTAssertEqual(count, 1)
    }
}
