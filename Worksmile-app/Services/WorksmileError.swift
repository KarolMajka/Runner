//
//  WorksmileError.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation

enum WorksmileError: Error {
    case notFound
}

// MARK: - LocalizedError
extension WorksmileError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return L10n.locErrorNotFound
        }
    }
}
