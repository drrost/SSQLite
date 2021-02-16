//
//  SQLiteConnection.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation
import SQLite3

class SQLiteConnection: Connection {

    private let url: String
    private let db: OpaquePointer?

    init(_ url: String) throws {
        self.url = url
        var _db: OpaquePointer?
        let result = sqlite3_open_v2(url, &_db, SQLITE_OPEN_READWRITE, nil)
        if result != SQLITE_OK {
            let message = String(cString: sqlite3_errmsg(_db))
            throw SQLException(message)
        }
        self.db = _db
    }

    func createStatement() throws -> Statement {
        throw SQLException("Not implemented yet", "000000")
    }

    func prepareStatement(_ sql: String) throws -> PreparedStatement {
        throw SQLException("Not implemented yet", "000000")
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
