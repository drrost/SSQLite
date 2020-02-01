//
//  SQLiteTest.swift
//  
//
//  Created by Rostyslav Druzhchenko on 31.01.2020.
//

import XCTest
@testable import swift_sqlite

private let kSqlCreateTable = "CREATE TABLE user(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT);"

final class SQLiteTest: XCTestCase {

    // MARK: -

    var sut: SQLite!

    // MARK: -

    override func setUp() {

        let url = URL(string: dbPath())!

        do {
             try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete file: \(error)")
        }

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
        _ = sut.open(dbPath())

        // When
        let result = sut.execute(kSqlCreateTable)

        // Then
        XCTAssertEqual(0, result)
    }

    // MARK: - Insert

    func testInsert() {
        // Given
        _ = sut.open(dbPath())
        _ = sut.execute(kSqlCreateTable)
        let sql = "INSERT INTO user (first_name, last_name) VALUES ('Deve', 'Cooper');"

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
