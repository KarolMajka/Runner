//
//  ReusableView.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
