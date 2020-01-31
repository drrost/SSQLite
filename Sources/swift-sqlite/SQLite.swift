//
//  SQLite.swift
//  
//
//  Created by Rostyslav Druzhchenko on 31.01.2020.
//

import Foundation
import SQLite3

class SQLite {

    // MARK: - Variables

    private let logger: ILogger

    private var db: OpaquePointer?

    // MARK: - Init

    init(_ logger: ILogger = Logger()) {

        self.logger = logger
    }

    // Opens a file with SQLite database

    func open(_ path: String) -> Bool {

        // Open (or create) data base
        if sqlite3_open(path, &db) == SQLITE_OK {
            return true
        } else {
            return false
        }
    }

    // Executes an SQL exression on database

    func execute(_ expression: String) -> Int {

        // Create a pointer to statement
        var statement: OpaquePointer?

        defer {
            // Free system resources
            sqlite3_finalize(statement)
        }

        // Prepare SQL statement
        var result = sqlite3_prepare_v2(db, expression, -1, &statement, nil)
        guard result == SQLITE_OK else {
            logger.log("`sqlite3_prepare_v2(...)` function failed with code: \"\(result)\", for expression \(expression)")
            return Int(result)
        }

        // Execute the statement
        result = sqlite3_step(statement)
        guard result == SQLITE_DONE else {
            logger.log("SQL execution failed. `sqlite3_step(...)` function failed with code: \"\(result)\", for expression \(expression)")
            return Int(result)
        }

        return 0
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
