//
//  DeviceInformationTests.swift
//  
//
//  Created by Tatsuya Tanaka on 2021/12/25.
//

import XCTest
import AppEntity

class DeviceInformationTests: XCTestCase {
    func testAAA() {
        let info = DeviceInformation()
        let os = info.os.components(separatedBy: " ")
        if #available(iOS 15, *) {
            XCTAssertEqual(os[1].components(separatedBy: ".").first, "15")
        } else if #available(iOS 14, *) {
            XCTAssertEqual(os[1].components(separatedBy: ".").first, "14")
        }
    }
}
