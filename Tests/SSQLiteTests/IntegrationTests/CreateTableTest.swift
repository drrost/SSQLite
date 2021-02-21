//
//  CreateTableTest.swift
//
//
//  Created by Rostyslav Druzhchenko on 20.02.2021.
//

import XCTest
import SQLite3

@testable import SSQLite

class CreateTableTest: XCTestCase {

    // MARK: - Init tests

    func testCreateTable() {
        // Given
        let dbName = "user.db"
        let dbPath = Bundle.module.path(for: dbName)
        let connection = try! DriverManager.getConnection(dbPath)
        let sql = "CREATE TABLE test (test_id INTEGER, name TEXT);"

        // When
        let statement = try! connection.createStatement()
        let code = try! statement.executeUpdate(sql)

        // Then
        XCTAssertEqual(SQLITE_OK, code)
    }

    func testCreateTableTwice_ThrowsError() {
        // Given
        let dbName = "user.db"
        let dbPath = Bundle.module.path(for: dbName)
        let connection = try! DriverManager.getConnection(dbPath)
        let sql = "CREATE TABLE test2 (test_id INTEGER, name TEXT);"

        // When
        let statement = try! connection.createStatement()
        let code = try! statement.executeUpdate(sql)
        XCTAssertEqual(SQLITE_OK, code)

        do {
            _ = try statement.executeUpdate(sql)
            XCTAssertTrue(
                false, "The code should throw earlier and not achieve this line")
        } catch let error as SQLException {
            // Then
            XCTAssertEqual("table test2 already exists", error.detailedMessage)
        } catch {
            XCTAssertTrue(
                false, "The code should not throw any errors but SQLException")
        }
    }
}
