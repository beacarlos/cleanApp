//
//  Model.swift
//  CleanApp
//
//  Created by Beatriz Carlos on 16/12/20.
//

import Foundation

protocol Model: Encodable {}

extension Model {
    public func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
