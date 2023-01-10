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
    
    var sections: [TwoLabelsItem] {
        bindableSections.value
    }

    lazy var bindableSections = makeSections()

    private func makeSections() -> Bindable<[TwoLabelsItem]> {
        let twoLabelsItems = HTTPStatusCode.allCases.map { statusCode in
                TwoLabelsItem(leftTitle: "\(statusCode.rawValue)", wasTapped: .init(value: false))
        }
        return .init(value: twoLabelsItems)
    }
    
    // MARK: – Methods –
    
    func didSelect(section: Int) {
        sections[section].wasTapped.value = true
        showCatDetails(sections[section].leftTitle)

        remakeSectionsSoThatLastSelectedSectionIsFirst(selectedSection: section)
    }
    
    // MARK: – Remake sections –
    
    private func remakeSectionsSoThatLastSelectedSectionIsFirst(selectedSection: Int) {
        var sections = sections
        let selectedTwoLabelsItem = sections.remove(at: selectedSection)
        sections.insert(selectedTwoLabelsItem, at: 0)
        bindableSections.value = sections
    }
}
