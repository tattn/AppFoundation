//
//  AppFoundation.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/12/1.
//

import Foundation
import AppData

public enum AppFoundation {
    public static func configure(with configuration: Configuration = .init()) {
        let defaults = UserDefaults.standard
        defaults.set((defaults.value(for: .appLaunchCount) ?? 0) + 1, for: .appLaunchCount)
    }
    
    public struct Configuration {
        public init() {}
    }
}
