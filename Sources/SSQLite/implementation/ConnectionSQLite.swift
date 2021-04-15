//
//  ConnectionSQLite.swift
//  A part of git@github.com:drrost/SSQLite.git project
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation
import SQLite3

public typealias DB = OpaquePointer

class ConnectionSQLite: Connection {

    private let url: String
    private let db: OpaquePointer?

    init(_ url: String) throws {
        self.url = url
        var _db: OpaquePointer?
        if sqlite3_open(url, &_db) != SQLITE_OK {
            let message = String(cString: sqlite3_errmsg(_db))
            throw SQLException(message)
        }
        self.db = _db
    }

    func getDb() -> DB? {
        db
    }

    func createStatement() throws -> Statement {
        StatementSQLite(self)
    }

    func prepareStatement(_ sql: String) throws -> PreparedStatement {
        PreparedStatementSqlite(self, sql)
    }

    func close() throws {
        let result = sqlite3_close(db)
        if result != SQLITE_OK {
            let message = getLastErrorMessage()
            throw SQLException(message, "07003")
        }
    }

    func isClosed() throws -> Bool {
        throw SQLException("Not implemented yet", "000000")
    }

    private func getLastErrorMessage() -> String {
        String(cString: sqlite3_errmsg(db))
    }

    deinit {
        try? close()
    }
}
