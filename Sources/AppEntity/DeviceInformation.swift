//
//  DeviceInformation.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/12/03.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public struct DeviceInformation: Sendable {
    public let os: String
    public let device: String
    public let appVersion: String
    public let language: String

    @MainActor
    public init() {
        #if canImport(UIKit)
        os = "iOS \(UIDevice.current.systemVersion)"
        #else
        os = NSProcessInfo.processInfo().operatingSystemVersion
        #endif
        device = Self.deviceName()
        appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        language = Locale.current.language.languageCode?.identifier ?? "Unknown"
    }
    
    private static func deviceName() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
        }
        var sysinfo = utsname()
        _ = uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
}
