//
//  Array+SafeAccess.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
