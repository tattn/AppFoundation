import XCTest
@testable import AppData

final class UserDefaultsTests: XCTestCase {
    func testStoreDate() {
        let date = Date()
        UserDefaults.standard.set(date, for: .testDate)
        XCTAssertEqual(date, UserDefaults.standard.value(for: .testDate))
        UserDefaults.standard.remove(for: .testDate)
    }
}

private extension UserDefaults.Key {
    static var testDate: Key<Date> { "af_test_date" }
}
