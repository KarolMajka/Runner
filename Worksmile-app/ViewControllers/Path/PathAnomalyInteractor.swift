//
//  PathAnomalyInteractor.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation

protocol PathAnomalyInteractorProtocol {
    func markAnomalyPoints(points: inout [Point])
}

final class PathAnomalyInteractor: PathAnomalyInteractorProtocol {
    private let maxPossibleDistance = 0.01

    func markAnomalyPoints(points: inout [Point]) {
        for (index, point) in points.enumerated() {
            let previousPoint = points[safe: index-1]
            let nextPoint = points[safe: index+1]

            let previousPointDistance = previousPoint?.distance
            let nextPointDistance = nextPoint?.distance

            guard previousPointDistance != nil || nextPointDistance != nil else {
                points[index].isAnomaly = false
                continue
            }

            let pointDistance = point.distance

            let isAnomaly = (previousPointDistance == nil || pointDistance - (previousPointDistance ?? 0) > maxPossibleDistance) && (nextPointDistance == nil || (nextPointDistance ?? 0) - pointDistance > maxPossibleDistance)
            points[index].isAnomaly = isAnomaly
        }
    }
}
