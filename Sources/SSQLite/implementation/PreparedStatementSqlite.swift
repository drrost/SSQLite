//
//  PreparedStatementSqlite.swift
//
//
//  Created by Rostyslav Druzhchenko on 21.02.2021.
//

import Foundation
import SQLite3

class PreparedStatementSqlite: StatementSQLite, PreparedStatement {

    private let sql: String
    private var batch: [DataTypePair]

    private enum DataType {
        case int
        case text
        case real
        case null
    }

    private class DataTypePair {
        var type: DataType
        var value: Any
        init(_ type: DataType, _ value: Any) {
            self.type = type
            self.value = value
        }
    }

    init(_ connection: Connection, _ sql: String) {
        self.sql = sql
        let count = sql.occurrencesCount("?")
        self.batch = [DataTypePair]()
        for _ in 0 ..< count {
            self.batch.append(DataTypePair(.null, NSNull()))
        }
        super.init(connection)
    }

    // MARK: - PreparedStatement

    func setNull(_ parameterIndex: Int, _ sqlType: Int) throws {
        throw SQLException("Not implemented yet", "000000")
    }

    func setBoolean(_ parameterIndex: Int, _ x: Bool) throws {
        throw SQLException("Not implemented yet", "000000")
    }

    func setInt(_ parameterIndex: Int, _ x: Int) throws {
        batch[parameterIndex - 1].value = x
        batch[parameterIndex - 1].type = .int
    }

    func setDouble(_ parameterIndex: Int, _ x: Double) throws {
        throw SQLException("Not implemented yet", "000000")
    }

    func setString(_ parameterIndex: Int, _ x: String) throws {
        batch[parameterIndex - 1].value = x
        batch[parameterIndex - 1].type = .text
    }

    func executeUpdate() throws -> Int32 {
        // Avoid SQLITE_MISUSE error
        guard sql.trimN().count > 0 else { return 0 }

        guard let db = connection?.getDb() else {
            throw SQLException("Can't prepare statement, connection is nil")
        }

        let binded = try bind()

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, binded, -1, &statement, nil) != SQLITE_OK {
            throw SQLException(
                "Can't prepare statment with SQL: \"\(sql)\"",
                detailed: getNativeError(db))
        }

        if sqlite3_step(statement) != SQLITE_DONE {
            throw SQLException("sqlite3_step failed with error: \"\(getNativeError(db))\"")
        }

        sqlite3_finalize(statement)

        return SQLITE_OK
    }

    // MARK: - Private

    private func bind() throws -> String {

        var inSql = sql

        for element in batch {
            let string = try elementToString(element)
            inSql = inSql.replaceFirstOccurrence("?", string)
        }

        return inSql
    }

    private func elementToString(_ element: DataTypePair) throws -> String {
        switch element.type {
            case .int:
                return "\(element.value)"
            case .text:
                if let value = element.value as? String {
                    return "'\(value)'"
                } else {
                    throw SQLException("Can't convert value to String," +
                                        " value: \"\(element.value)\"")
                }
            case .real:
                return "\(element.value)"
            default:
                throw SQLException("Unsupported type: \(element.type)")
        }
    }
}
