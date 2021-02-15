//
//  SQLiteConnection.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

class SQLiteConnection: Connection {

    private let url: String

    init(_ url: String) {
        self.url = url
    }

    func createStatement() throws -> Statement {
        throw SQLException("Not implemented yet", "000000")
    }

    func prepareStatement(_ sql: String) throws -> PreparedStatement {
        throw SQLException("Not implemented yet", "000000")
    }

    func close() throws {
        throw SQLException("Not implemented yet", "000000")
    }

    func isClosed() throws -> Bool {
        throw SQLException("Not implemented yet", "000000")
    }
}
