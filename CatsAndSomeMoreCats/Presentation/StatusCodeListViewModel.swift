//
//  StatusCodeListViewModel.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 09.01.23.
//

import Foundation

class StatusCodeListViewModel {
    // MARK: – Properties –
    
    var showCatDetails: ((Int) -> Void)!
    
    func didSelect(index: Int) {
        showCatDetails(100)
    }
}
