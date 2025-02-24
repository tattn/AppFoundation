//
//  UserDefaults+Type.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/12/15.
//

import Foundation

public extension UserDefaults {
    func value<T>(for key: Key<T>) -> T {
        object(forKey: key.rawValue) as? T ?? key.defaultValue()
    }

    func set<T>(_ value: T, for key: Key<T>) {
        set(value, forKey: key.rawValue)
    }
    
    func remove<T>(for key: Key<T>) {
        removeObject(forKey: key.rawValue)
    }
}

public extension UserDefaults {
    struct Key<Value: Sendable>: Sendable {
        public let rawValue: String
        public let defaultValue: @Sendable () -> Value

        public init(_ rawValue: String, default defaultValue: @Sendable @autoclosure @escaping () -> Value) {
            self.rawValue = rawValue
            self.defaultValue = defaultValue
        }
    }
}

public extension UserDefaults.Key<Int> {
    static var appLaunchCount: Self {
        .init("af_appLaunchCount", default: 0)
    }
}

public extension UserDefaults.Key<Date?> {
    static var lastAppLaunchDate: Self {
        .init("af_lastAppLaunchDate", default: nil)
    }
}
