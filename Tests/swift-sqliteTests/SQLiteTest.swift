//
//  SQLiteTest.swift
//  
//
//  Created by Rostyslav Druzhchenko on 31.01.2020.
//

import XCTest
@testable import swift_sqlite

final class SQLiteTest: XCTestCase {

    // MARK: -

    var sut: SQLite!

    // MARK: -

    override func setUp() {

        sut = SQLite()
    }

    // MARK: - Opening

    func testOpeningSucceede() {

        // Given
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let dbPath = thisDirectory.absoluteString + "../db/empty.db"

        // When
        let result = sut.open(dbPath)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Create a table

    func testCreateTable() {

        // Given
        let sql = "CREATE TABLE user(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT);"
        _ = sut.open(dbPath())

        // When
        let result = sut.execute(sql)

        // Then
        XCTAssertEqual(0, result)
    }
}

// MARK: - Helpers

private extension SQLiteTest {

    func dbPath() -> String {
        let file = URL(fileURLWithPath: #file)
        let directory = file.deletingLastPathComponent()
        return directory.absoluteString + "../db/empty.db"
    }
}
