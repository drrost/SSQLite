//
//  ResultSetSqlite.swift
//  A part of git@github.com:drrost/SSQLite.git project
//
//  Created by Rostyslav Druzhchenko on 18.02.2021.
//

import Foundation
import RDError
import SQLite3

class ResultSetSqlite: ResultSet {

    private weak var statement: Statement!

    var columns: [String]
    var row: Int = 0

    init(_ statement: Statement) {
        self.statement = statement
        columns = [String]()
    }

    func next() throws -> Bool {
        let statusCode = doSetp()
        switch statusCode {
            case SQLITE_DONE:
                return false
            case SQLITE_ROW:
                row += 1
                return true
            default:
                throw SQLException("Unknown status code: \(statusCode)")
        }
    }

    func getInt(_ columnLabel: String) throws -> Int {
        guard let index = columns.firstIndex(of: columnLabel) else {
            throw SQLException("Can't find column: \"\(columnLabel)\"")
        }
        let index32 = Int32(index)
        return Int(sqlite3_column_int64(statement.getNative(), index32))
    }

    func getDouble(_ columnLabel: String) throws -> Double {
        throw RDError("Method is not implmeneted")
    }

    func getString(_ columnLabel: String) throws -> String {
        guard let index = columns.firstIndex(of: columnLabel) else {
            throw SQLException("Can't find column: \"\(columnLabel)\"")
        }
        let index32 = Int32(index)

        if let valuePtr = sqlite3_column_text(statement.getNative(), index32) {
            return String(cString: valuePtr)
        }

        return "NULL"
    }

    func getBool(_ columnLabel: String) throws -> Bool {
        throw RDError("Method is not implmeneted")
    }

    // MARK: - Private

    private func doSetp() -> Int32 {
        sqlite3_step(statement!.getNative())
    }
}
