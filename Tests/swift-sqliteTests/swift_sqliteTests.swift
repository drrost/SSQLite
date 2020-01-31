import XCTest
@testable import swift_sqlite

final class swift_sqliteTests: XCTestCase {

    func testExample() {
        XCTAssertEqual(swift_sqlite().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
