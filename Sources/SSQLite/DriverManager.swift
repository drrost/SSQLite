//
//  DriverManager.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public class DriverManager {

    static func getConnection(_ url: String?) throws -> Connection {

        guard url != nil else {
            throw SQLException("The url cannot be null", "08001")
        }

        // TODO: Check
//        isValidUrl(url)

        return SQLiteConnection(url!)
    }
}
