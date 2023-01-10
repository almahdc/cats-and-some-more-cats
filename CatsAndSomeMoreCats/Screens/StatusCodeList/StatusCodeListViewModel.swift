//
//  StatusCodeListViewModel.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import Foundation

final class StatusCodeListViewModel {
    // MARK: – Actions –
    
    var showCatDetails: Action1<String>!
    
    // MARK: – Sections –
    
    lazy var sections = makeSections()

    private func makeSections() -> [TwoLabelsItem] {
        HTTPStatusCode.allCases.map { statusCode in
                .init(leftTitle: "\(statusCode.rawValue)", wasTapped: .init(value: false))
        }
    }
    
    // MARK: – Methods –
    
    func didSelect(section: Int) {
        sections[section].wasTapped.value = true
        showCatDetails(sections[section].leftTitle)
    }
}
