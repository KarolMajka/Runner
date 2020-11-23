//
//  PathMapCellViewModelTests.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 22/11/2020.
//

import XCTest
@testable import Worksmile_app
import MapKit

final class PathMapCellViewModelTests: XCTestCase {

    func testPolygon() {
        let points = try! MockPointsService(shouldFail: false).fetchPoints().compactMap { $0.point }

        let cell = PathMapCellViewModel(dependencies: .init(points: points))
        let route = cell.output.cell.route

        XCTAssertNotNil(route)
        XCTAssertEqual(route!.pointCount, points.count)

        var routeCoords: [CLLocationCoordinate2D] = .init(repeating: kCLLocationCoordinate2DInvalid,
                                              count: route!.pointCount)

        route!.getCoordinates(&routeCoords, range: NSRange(location: 0, length: route!.pointCount))

        let pointCoords = points.map { $0.location.coordinate }

        let accuracy = 0.0000001
        for (routeCord, pointCoord) in zip(routeCoords, pointCoords) {
            XCTAssertEqual(routeCord.latitude, pointCoord.latitude, accuracy: accuracy)
            XCTAssertEqual(routeCord.longitude, pointCoord.longitude, accuracy: accuracy)
        }
    }
}
