//
//  PointResponse.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation
import CoreLocation

struct PointResponse: Decodable {
    let longitude: String?
    let latitude: String?

    let altitude: String?
    let accuracy: String?

    let timestamp: String?
    let distance: String?

    var location: CLLocation? {
        guard let longitude = longitude?.double, let latitude = latitude?.double, let altitude = altitude?.double, let accuracy = accuracy?.double, let timestamp = timestamp?.double else { return nil }

        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = CLLocation(
            coordinate: coordinate,
            altitude: altitude,
            horizontalAccuracy: accuracy,
            verticalAccuracy: accuracy,
            timestamp: Date(timeIntervalSinceReferenceDate: timestamp)
        )

        return location
    }
}

// MARK: - Lenses
extension PointResponse {
    var point: Point? {
        guard let distance = distance?.double, let location = location else { return nil }
        return Point(distance: distance, location: location)
    }
}
