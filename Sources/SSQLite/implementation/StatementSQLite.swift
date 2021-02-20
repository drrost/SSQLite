//
//  StatementSQLite.swift
//
//
//  Created by Rostyslav Druzhchenko on 18.02.2021.
//

import Foundation
import RDError
import SQLite3

public typealias StatementNative = OpaquePointer

class StatementSQLite: Statement {

    private weak var connection: Connection?
    private var rs: ResultSet!
    private var nativeStatement: OpaquePointer!

    // MARK: - Statement

    init(_ connection: Connection) {
        self.connection = connection
        rs = ResultSetSqlite(self)
    }

    func executeQuery(_ sql: String) throws -> ResultSet {
        guard let db = connection?.getDb() else {
            throw SQLException("Can't prepare statement, connection is nil")
        }

        let code = sqlite3_prepare_v2(db, sql, -1, &nativeStatement, nil)
        if code != SQLITE_OK {
            let nativeErrorMessage = String(cString: sqlite3_errmsg(db))
            throw SQLException("Statement creattion failed with code \(code)",
                               detailed: nativeErrorMessage)
        }

        return try getResultSet()
    }

    func executeUpdate(_ sql: String) throws -> Int {
        throw RDError("Method is not implmeneted")
    }

    func close() throws {
        throw RDError("Method is not implmeneted")
    }

    func getResultSet() throws -> ResultSet {
        rs.columns = fetchColumnNames(nativeStatement)
        return rs
    }

    func getNative() -> StatementNative {
        nativeStatement
    }

    // MARK: - Public

    func fetchColumnNames(_ statement: StatementNative?) -> [String] {

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
}
