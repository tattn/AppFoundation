//
//  UserDefaults+Type.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/12/15.
//

import Foundation

public extension UserDefaults {
    func value<T>(for key: Key<T>) -> T? {
        object(forKey: key.rawValue) as? T
    }

    func set<T>(_ value: T, for key: Key<T>) {
        set(value, forKey: key.rawValue)
    }
    
    func remove<T>(for key: Key<T>) {
        removeObject(forKey: key.rawValue)
    }
}

public extension UserDefaults {
    struct Key<Value>: RawRepresentable {
        public let rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension UserDefaults.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(rawValue: value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(rawValue: value)
    }
}

public extension UserDefaults.Key {
    typealias Key = UserDefaults.Key
    static var appLaunchCount: Key<Int> { "af_appLaunchCount" }
}
