//
//  JSONDecoder+default.swift
//  Worksmile-app
//
//  Created by Karol Majka on 21/11/2020.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
