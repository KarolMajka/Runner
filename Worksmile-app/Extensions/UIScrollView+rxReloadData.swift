//
//  UIScrollView+rxReloadData.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var reloadData: Binder<Void> {
        return .init(base, binding: { (scrollView, _) in
            switch scrollView {
            case let tableView as UITableView:
                tableView.reloadData()
            case let collectionView as UICollectionView:
                collectionView.reloadData()
            default:
                scrollView.setNeedsLayout()
            }
        })
    }
}
