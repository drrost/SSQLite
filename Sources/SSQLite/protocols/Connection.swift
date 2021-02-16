//
//  Connection.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public protocol Connection {

    func createStatement() throws -> Statement
    func prepareStatement(_ sql: String) throws -> PreparedStatement
    func close() throws
    func isClosed() throws -> Bool
}
