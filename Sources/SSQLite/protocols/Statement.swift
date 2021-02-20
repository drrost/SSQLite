//
//  Statement.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public protocol Statement: AnyObject {

    func executeQuery(_ sql: String) throws -> ResultSet
    func executeUpdate(_ sql: String) throws -> Int
    func close() throws

    func getResultSet() throws -> ResultSet

    func getNative() -> StatementNative
}
