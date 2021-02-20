//
//  SimpleSelectTest.swift
//
//
//  Created by Rostyslav Druzhchenko on 20.02.2021.
//

import XCTest

@testable import SSQLite

class SimpleSelectTest: XCTestCase {

    // MARK: - Init tests

    func testSelectUsers() {
        // Given
        let dbName = "user.db"
        let dbPath = Bundle.module.path(for: dbName)
        let connection = try! DriverManager.getConnection(dbPath)
        let sql = "SELECT * FROM user;"

        // When
        let statement = try! connection.createStatement()
        let rs = try! statement.executeQuery(sql)

        var userList = [User]()
        do {
            while try rs.next() {
                let user = User()
                user.id = try rs.getInt("id")
                user.firstName = try rs.getString("first_name")
                user.lastName = try rs.getString("last_name")
                user.age = try rs.getInt("age")
                userList.append(user)
            }
        } catch {
            XCTAssertTrue(
                false, "stepping through rs should not throw exceptions.\n" +
                    "Failed with \"\(error.localizedDescription)\"")
        }

        // Then
        XCTAssertEqual(rs.columns.count, 4)
        XCTAssertEqual(16, userList.count)
    }
}
