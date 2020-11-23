//
//  PathAnomalyInteractorTests.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 22/11/2020.
//

import XCTest
@testable import Worksmile_app

final class PathAnomalyInteractorTests: XCTestCase {

    func testAnomalyPointsDetection() throws {
        let points = [
            Point(distance: 0, location: .init(), isAnomaly: false),
            Point(distance: 0.001, location: .init(), isAnomaly: false),
            Point(distance: 0.00999, location: .init(), isAnomaly: false),
            Point(distance: 0.01, location: .init(), isAnomaly: false),
            Point(distance: 0.01.nextUp, location: .init(), isAnomaly: false),
            Point(distance: 0.02, location: .init(), isAnomaly: false),
            Point(distance: 0.03.nextUp, location: .init(), isAnomaly: true),
            Point(distance: 0.1, location: .init(), isAnomaly: true),
            Point(distance: 0.2, location: .init(), isAnomaly: false),
            Point(distance: 0.2, location: .init(), isAnomaly: false),
            Point(distance: 100, location: .init(), isAnomaly: true)
        ]
        var anomalyPoints = points
        PathAnomalyInteractor().markAnomalyPoints(points: &anomalyPoints)

        XCTAssertEqual(anomalyPoints, points, "Anomaly detection failed")
    }
}
