//
//  File.swift
//  
//
//  Created by Rostyslav Druzhchenko on 31.01.2020.
//

import XCTest
@testable import swift_sqlite

final class SQLiteTest: XCTestCase {

    // MARK: - Opening

    func testOpeningSucceede() {

        // Given
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let dbPath = thisDirectory.absoluteString + "../db/empty.db"


        // When
        let sqLite = SQLite()
        let result = sqLite.open(dbPath)

        // Then
        XCTAssertTrue(result)
    }
}
