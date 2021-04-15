//
//  DriverManager.swift
//  A part of git@github.com:drrost/SSQLite.git project
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation
import ExtensionsFoundation

public class DriverManager {

    public static func getConnection(_ url: String?) throws -> Connection {

        guard let url = url else {
            throw SQLException("The url cannot be null", "08001")
        }

        guard isValidUrl(url) else {
            throw SQLException("The url is not valid", "08002")
        }

        guard FileManager.exists(url) else {
            throw SQLException("File does not exist", "08003")
        }

        return try ConnectionSQLite(url)
    }

    static func isValidUrl(_ url: String?) -> Bool {
        if let url = url, url.count > 0 {
            return true
        }
        return false
    }
}
