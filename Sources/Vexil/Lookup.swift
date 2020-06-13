//
//  FlagLookup.swift
//  Vexil
//
//  Created by Rob Amos on 25/5/20.
//

import Foundation

internal protocol Lookup: AnyObject {
    var configuration: VexilConfiguration { get }

    func lookup<Value> (key: String) -> Value? where Value: FlagValue
    func codingKey (label: String) -> String
}

extension FlagPole: Lookup {
    func lookup<Value> (key: String) -> Value? where Value: FlagValue {
        return self.sources
            .lazy
            .compactMap { $0.flagValue(key: key) }
            .first
    }

    func codingKey (label: String) -> String {
        return self.configuration.codingPathStrategy.codingKey(label: label)
    }
}