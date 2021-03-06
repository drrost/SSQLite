//
//  SQLiteTest.swift
//  
//
//  Created by Rostyslav Druzhchenko on 31.01.2020.
//

import XCTest
@testable import SSQLite

private let kEmptyDbName = "empty.db"
private let kUserDbName = "user.db"
private let kSqlCreateTable = "CREATE TABLE user(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, age INTETER);"

final class SQLiteTest: XCTestCase {

    // MARK: - Variables

    var sut: SQLite!

    // MARK: - Tests routines

    override func setUp() {

        let url = URL(string: dbPath() + kEmptyDbName)!

        do {
             try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete file: \(error)")
        }

        sut = SQLite()
    }

    // MARK: - Opening

    func testOpeningSucceeded() {

        // Given

        // When
        let result = sut.open(dbPath() + kEmptyDbName)

        // Then
        XCTAssertTrue(result)
    }

    func testOpenExisted_FileAbsent_False() {
        // Given
        // When
        let result = sut.openExisted("./absent.db")

        // Then
        XCTAssertFalse(result)
    }

    func testOpenExisted2_FileAbsent_False() {
        // Given
        // When
        let result = sut.openExisted("./dd")

        // Then
        XCTAssertFalse(result)
    }

    func testOpenExisted_FileExists_False() {
        // Given
        let path = dbPath() + kUserDbName

        // When
        let result = sut.openExisted(path)

        // Then
        XCTAssertTrue(result)
    }

    // MARK: - Create a table

    func testCreateTable() {

        // Given
        _ = sut.open(dbPath() + kEmptyDbName)

        // When
        let result = sut.execute(kSqlCreateTable)

        // Then
        XCTAssertEqual(0, result.errorCode)
    }

    // MARK: - Insert

    func testInsert() {
        // Given
        _ = sut.open(dbPath() + kEmptyDbName)
        _ = sut.execute(kSqlCreateTable)
        let sql = "INSERT INTO user (first_name, last_name, age) VALUES ('Dave', 'Cooper', 46);"

        // When
        let result = sut.execute(sql)

        // Then
        XCTAssertEqual(0, result.errorCode)
    }

    // MARK: - Select

    func testSelect() {
        // Given
        _ = sut.open(dbPath() + kUserDbName)
        let sql = "SELECT * FROM user;"

        // When
        let result = sut.execute(sql)

        // Then
        XCTAssertEqual(0, result.errorCode)
        XCTAssertEqual(16, result.rows.count)

        var users = [User]()
        for row in result.rows {
            users.append(User(with: row))
        }

        for i in 0 ..< users.count {
            XCTAssertEqual(i + 1, users[i].id)
        }

        XCTAssertEqual("Ramsey", users[0].firstName)
        XCTAssertEqual("Joiner", users[0].lastName)
        XCTAssertEqual(96, users[0].age)
    }
}

// MARK: - Helpers

extension XCTestCase {

    func dbPath() -> String {
        let file = URL(fileURLWithPath: #file)
        let directory = file.deletingLastPathComponent()
        return directory.absoluteString + "../db/"
    }
}

class User {

    // MARK: - Variables

    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var age: Int = 0

    // MARK: - Init

    init() {}

    init(with row: Row) {

        id = Int(row.value("id") as! Int64)
        firstName = row.value("first_name") as! String
        lastName = row.value("last_name") as! String
        age = Int(row.value("age") as! Int64)
    }
}
