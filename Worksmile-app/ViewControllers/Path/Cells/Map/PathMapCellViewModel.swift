//
//  PathMapCellViewModel.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import RxSwift
import MapKit

final class PathMapCellViewModel: CellViewModel {

    var output = Output()

    struct Dependencies {
        let points: [Point]
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()

        let pointsCoordinate = dependencies.points.map { $0.location.coordinate }
        let polyline = MKPolyline(coordinates: pointsCoordinate, count: pointsCoordinate.count)

        output.cell.route = polyline
    }

    func applyPreviousConfiguration(previousCell: PathMapCellViewModel) {
        output.cell.camera = previousCell.output.cell.camera
    }
}

// MARK: - Output
extension PathMapCellViewModel {
    struct Output {
        var cell = Cell()

        struct Cell {
            fileprivate(set) var route: MKPolyline?

            var camera: MKMapCamera?
        }
    }
}
