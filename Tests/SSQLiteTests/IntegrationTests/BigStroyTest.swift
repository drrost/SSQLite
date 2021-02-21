//
//  BigStroyTest.swift
//
//
//  Created by Rostyslav Druzhchenko on 16.02.2021.
//

import XCTest
import SQLite3

@testable import SSQLite

class BigStroyTest: XCTestCase {

    // MARK: - Init tests

    func testBigStory() {

        // Given

        let dbManager = DBManager()                                         // 1
        let connection = try! dbManager.connect()                           // 2

        let initSql = Bundle.module.path(for: "init.sql")

        do {
            let sql = try! String(contentsOf: initSql!)                     // 3
            let statement = try connection.createStatement()                // 4

            // When
            try statement.exec(sql)
        } catch {
            XCTAssertTrue(false, "code above should not throw")
        }

        // Then
        do {
            let sql = "SELECT * FROM user;"
            let statement = try connection.createStatement()                //
            let rs = try statement.executeQuery(sql)                        //

            var userList = [User]()
            while try rs.next() {                                           // 6
                let user = User()
                user.id = try rs.getInt("id")                               // 7
                user.firstName = try rs.getString("first_name")             // 8
                user.lastName = try rs.getString("last_name")               // 9
                user.age = try rs.getInt("age")                            // 10
                userList.append(user)
            }
            XCTAssertEqual(7, userList.count)
        } catch let error as SQLException {
            print(error.message)
            print(error.detailedMessage)
            XCTAssertTrue(false, "code above should not throw")
        } catch {
            XCTAssertTrue(
                false, "The code should not throw any errors but SQLException")
        }

        try! dbManager.erase()
    }
}
