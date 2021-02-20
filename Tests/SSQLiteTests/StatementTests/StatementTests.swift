//
//  StatementTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 19.02.2021.
//

import XCTest
import ExtensionsFoundation

@testable import SSQLite

class StatementTests: XCTestCase {

    // MARK: - Variables

    var sut: NSObject!

    // MARK: - Tests routines

    override func setUp() {
        sut = NSObject()
    }

    // MARK: - Init tests

    func testExecutionWithWrongSQL_Throws() {
        // Given
        let dbName = "user.db"
        let dbPath = Bundle.module.path(for: dbName)
        let connection = try! DriverManager.getConnection(dbPath)
        let sql = "SELEC * FROM user;"

        // When
        let statement = try! connection.createStatement()

        // Then
        XCTAssertThrowsError(try statement.executeQuery(sql))
    }
}

