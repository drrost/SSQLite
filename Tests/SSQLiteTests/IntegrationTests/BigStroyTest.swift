//
//  BigStroyTest.swift
//
//
//  Created by Rostyslav Druzhchenko on 16.02.2021.
//

import XCTest

@testable import ExtensionsFoundation

class BigStroyTest: XCTestCase {

    // MARK: - Init tests

    func testBigStory() {

        let dbManager = DBManager()                                         // 1
        let connection = try! dbManager.connect()                           // 2

        let initSql = Bundle.module.path(for: "init.sql")
        let sql = try! String(contentsOf: initSql!)                         // 3

        var userList = [User2]()
        do {
            let statement = try connection.createStatement()                // 4
            let rs = try statement.executeQuery(sql)                        // 5

            while try rs.next() {                                           // 6
                let user = User2()
                user.id = try rs.getInt("id")                               // 7
                user.firstName = try rs.getString("first_name")             // 8
                user.lastName = try rs.getString("last_name")               // 9
                user.age = try rs.getInt("age")                            // 10
                userList.append(user)
            }
        } catch {
            XCTAssertTrue(false, "code above should not throw")
        }

        XCTAssertEqual(10, userList.count)

        // Run it on the connection
        // Make a SELECT
        // Check if there is correct data there

        // Create a table
        // Insert several rows
        // Select the rows
        // Check the result
        //

        // Make the same for - update rows, delete rows, drop table

        // Process a big SQL script that creates several tables, inserts data,
        // creates triggers.

        try! dbManager.erase()


        // Given
        // When
        // Then
    }
}

