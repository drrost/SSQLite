//
//  SQLite.swift
//  
//
//  Created by Rostyslav Druzhchenko on 31.01.2020.
//

import Foundation
import SQLite3

class SQLite {

    private let logger: ILogger

    // MARK: - Init

    init(_ logger: ILogger = Logger()) {

        self.logger = logger
    }

    // Opens a file with SQLite database

    func open(_ path: String) -> Bool {

        var db: OpaquePointer?

        if sqlite3_open(path, &db) == SQLITE_OK {
            return true
        } else {
            return false
        }
    }

    // Executes an SQL exression on database

    func execute(_ expression: String) {

    }

    func create(_ path: String) {

    }
}

protocol ILogger {

    func log(_ message: String)
}

private class Logger: ILogger {

    func log(_ message: String) {
        print(message)
    }
}
