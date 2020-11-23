//
//  PointsService.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation

protocol PointsServiceProtocol {
    func fetchPoints() throws -> [PointResponse]
}

final class PointsService: PointsServiceProtocol {
    func fetchPoints() throws -> [PointResponse] {
        guard let url = Bundle.main.url(forResource: "path", withExtension: "json") else { throw WorksmileError.notFound }

        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder.default
            let points = try decoder.decode([PointResponse].self, from: jsonData)

            return points
        } catch {
            throw error
        }
    }
}
