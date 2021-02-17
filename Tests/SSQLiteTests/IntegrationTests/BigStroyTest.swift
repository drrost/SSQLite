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

        let dbManager = DBManager()
        let connection = try! dbManager.connect()

        // Get an empty existed file with data base
        // Copy it in a new place
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
