//
//  DriverManager.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public class DriverManager {

    static func getConnection(_ url: String?) throws -> Connection {

        guard let url = url else {
            throw SQLException("The url cannot be null", "08001")
        }

        guard isValidUrl(url) else {
            throw SQLException("The url is not valid", "08002")
        }

        return SQLiteConnection(url)
    }

    static func isValidUrl(_ url: String?) -> Bool {
        if let url = url, url.starts(with: "file:/") {
            return true
        }
        return false
    }
}
