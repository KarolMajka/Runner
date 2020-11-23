//
//  Point.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation
import CoreLocation

struct Point: Equatable {
    let distance: Double
    let location: CLLocation
    var isAnomaly: Bool = false
}
