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
        sqlite3_open(path, &db) == SQLITE_OK
    }

    // Executes an SQL exression on database

    func execute(_ expression: String) -> QueryResult {

        // Declare a pointer to statement
        var statement: OpaquePointer?

        defer {
            // Free system resources
            sqlite3_finalize(statement)
        }

        // Declare result variable
        var queryResult = QueryResult()

        // Prepare SQL statement
        queryResult.errorCode = Int(sqlite3_prepare_v2(db, expression, -1, &statement, nil))
        guard queryResult.errorCode == SQLITE_OK else {

            // Compose final error message
            queryResult.composeErrorMessage(with: "sqlite3_prepare_v2", expression, db)
            logger.log(queryResult.errorMessage)

            return queryResult
        }

        // Fetch colum names
        queryResult.columnNames = fetchColumnNames(from: statement)

        // Fetch data
        queryResult.rows = fetchData(from: statement, queryResult.columnNames.count)

        return queryResult
    }

}

// MARK: - Private

private extension SQLite {

    func fetchColumnNames(from statement: OpaquePointer?) -> [String] {

        // Declare variables
        var columnNames = [String]()
        let count = sqlite3_column_count(statement)

        // Iterate the columns
        for i in 0 ..< count {

            if
                let namePtr = sqlite3_column_name(statement, i),
                let name = NSString(utf8String: namePtr) {

                columnNames.append(name as String)
            } else {
                columnNames.append("\(i)")
            }
        }

        return columnNames
    }

    func fetchData(from statement: OpaquePointer?, _ count: Int) -> [Row] {

        var rows = [Row]()

        // Iterate through all the rows
        while sqlite3_step(statement) == SQLITE_ROW {

            var row = Row()

            // Iterrate all the values in the row
            for i in 0 ..< Int32(count) {
                let columnType = sqlite3_column_type(statement, i)

                switch columnType {

                // Fetch Integer
                case SQLITE_INTEGER:
                    let value = sqlite3_column_int64(statement, i)
                    row.values.append(value)

                // Fetch Text
                case SQLITE_TEXT:

                     if let valuePtr = sqlite3_column_text(statement, i) {

                        let value = String(cString: valuePtr)
                        row.values.append(value as String)
                    } else {
                        row.values.append(NSNull())
                    }

                default:
                    print("TODO for: \(columnType)")
                }
            }

            rows.append(row)
        }

        return rows
    }
}

private extension QueryResult {

    mutating func composeErrorMessage(with function: String, _ expression: String, _ db: OpaquePointer?) {

        // Compose final error message
        let nativeErrorMessage = String(cString: sqlite3_errmsg(db))
        errorMessage = "`\(function)(...)` function failed.\n" +
            "    With SQLite error code: \"\(errorCode)\",\n" +
            "    With SQLite error message: \"\(nativeErrorMessage)\",\n" +
            "    For expression \"\(expression)\""
    }
}

// MARK: - Helpers

struct QueryResult {

    var errorCode: Int = 0
    var errorMessage: String = ""
    var rows: [Row] = [Row]()
    var columnNames = [String]()
    var columnTypes = [Any]()
}

struct Row {

    var columnNames = [String]()
    var values = [Any]()
}

protocol ILogger {

    func log(_ message: String)
}

private class Logger: ILogger {

    func log(_ message: String) {
        print(message)
    }
}
