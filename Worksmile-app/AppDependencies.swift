//
//  AppDependencies.swift
//  Worksmile-app
//
//  Created by Karol Majka on 22/11/2020.
//

import Foundation

final class AppDependencies {

    static var current: AppDependencies {
        return `default`
    }

    static let `default` = AppDependencies(pointsService: PointsService())
    static let mocked = AppDependencies(pointsService: MockPointsService(shouldFail: false))

    let pointsService: PointsServiceProtocol

    init(pointsService: PointsServiceProtocol) {
        self.pointsService = pointsService
    }
}
