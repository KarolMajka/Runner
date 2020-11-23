//
//  MockPointsService.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 22/11/2020.
//

import Foundation

final class MockPointsService: PointsServiceProtocol {

    private let shouldFail: Bool

    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }

    func fetchPoints() throws -> [PointResponse] {
        guard shouldFail == false else { throw WorksmileError.notFound }

        return [
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "1", distance: "0.0001"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "2", distance: "0.0002"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "3", distance: "0.5"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "4", distance: "0.5001"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "5", distance: "0.5001"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "6", distance: "0.5001"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "7", distance: "1.0"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "8", distance: "1.0001"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "9", distance: "1.0002"),
            PointResponse(longitude: "19.123", latitude: "50.123", altitude: "0", accuracy: "0", timestamp: "10", distance: "1.0003")
        ]
    }
}
