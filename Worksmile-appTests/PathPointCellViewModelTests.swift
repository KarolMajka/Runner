//
//  PathPointCellViewModelTests.swift
//  Worksmile-appTests
//
//  Created by Karol Majka on 22/11/2020.
//

import XCTest
@testable import Worksmile_app

final class PathPointCellViewModelTests: SnapshotTestCase {

    override var recordingMode: Bool {
        return super.recordMode
    }

    func testRegularCell() throws {
        let point = Point(distance: 40, location: .init(latitude: 20.123456, longitude: 20.2), isAnomaly: false)
        let cellViewModel = PathPointCellViewModel(dependencies: .init(point: point))

        XCTAssertEqual(cellViewModel.output.cell.anomalyIsHidden, true)
        XCTAssertEqual(cellViewModel.output.cell.cellBackgroundColor, UIColor.systemBackground)
        XCTAssertEqual(cellViewModel.output.cell.coordinateText, "(20,12346, 20,2)")
        XCTAssertEqual(cellViewModel.output.cell.distanceText, "40 km")

        let container = TableViewCellSnapshotContainerView<PathPointTableViewCell>(configureCell: { cell in
            cell.configure(withViewModel: cellViewModel)
        })
        verifyView(view: container, useSnapshotContainerView: false, identifier: "PathPointCellViewModel_without_anomaly")
    }

    func testAnomalyCell() throws {
        let point = Point(distance: 0.1, location: .init(latitude: 20, longitude: 20.21), isAnomaly: true)
        let cellViewModel = PathPointCellViewModel(dependencies: .init(point: point))

        XCTAssertEqual(cellViewModel.output.cell.anomalyIsHidden, false)
        XCTAssertEqual(cellViewModel.output.cell.cellBackgroundColor, UIColor.systemYellow)
        XCTAssertEqual(cellViewModel.output.cell.coordinateText, "(20, 20,21)")
        XCTAssertEqual(cellViewModel.output.cell.distanceText, "100 m")

        let container = TableViewCellSnapshotContainerView<PathPointTableViewCell>(configureCell: { cell in
            cell.configure(withViewModel: cellViewModel)
        })
        verifyView(view: container, useSnapshotContainerView: false, identifier: "PathPointCellViewModel_with_anomaly")
    }
}
