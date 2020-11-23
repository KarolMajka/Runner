//
//  CellsDataSource.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit

protocol CellsDataSource {
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModel
}

extension CellsDataSource {
    func numberOfSections() -> Int {
        return 1
    }
}
