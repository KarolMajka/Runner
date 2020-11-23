//
//  TableViewCell.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit
import RxSwift

class TableViewCell<T>: UITableViewCell where T: CellViewModel {
    var cellViewModel: T!

    var disposeBag = DisposeBag()

    func configure(withViewModel viewModel: T) {
        cellViewModel = viewModel
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
