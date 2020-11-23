//
//  PathPointCellViewModel.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import RxSwift
import MapKit.MKDistanceFormatter

final class PathPointCellViewModel: CellViewModel {

    private static let distanceFormatter = MKDistanceFormatter()
    fileprivate static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 5
        return formatter
    }()

    fileprivate(set) var output = Output()

    struct Dependencies {
        let point: Point
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()

        let point = dependencies.point

        output.cell.coordinateText = point.readableCoordinate
        output.cell.distanceText = PathPointCellViewModel.distanceFormatter.string(fromDistance: point.distance*1000)

        output.cell.anomalyIsHidden = point.isAnomaly == false
        output.cell.cellBackgroundColor = point.isAnomaly ? .systemYellow : .systemBackground
    }
}

// MARK: - Output
extension PathPointCellViewModel {
    struct Output {
        fileprivate(set) var cell = Cell()

        struct Cell {
            fileprivate(set) var coordinateText: String?
            fileprivate(set) var distanceText: String?

            fileprivate(set) var anomalyIsHidden: Bool = false
            fileprivate(set) var cellBackgroundColor: UIColor?
        }
    }
}

private extension Point {
    var readableCoordinate: String {
        let formatter = PathPointCellViewModel.numberFormatter
        let coordinate = location.coordinate

        let lat = formatter.string(for: coordinate.latitude) ?? String(format: "%.5f", coordinate.latitude)
        let lng = formatter.string(for: coordinate.longitude) ?? String(format: "%.5f", coordinate.longitude)

        return String(format: "(%@, %@)", lat, lng)
    }
}
