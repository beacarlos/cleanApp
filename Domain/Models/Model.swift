//
//  Model.swift
//  CleanApp
//
//  Created by Beatriz Carlos on 16/12/20.
//

import Foundation

public protocol Model: Encodable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
