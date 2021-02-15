//
//  PreparedStatement.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public protocol PreparedStatement {

    func executeQuery() throws -> ResultSet;
    func executeUpdate() throws -> Int;

    func setNull(_ parameterIndex: Int, _ sqlType: Int) throws;
    func setBoolean(_ parameterIndex: Int, _ x: Bool) throws;
    func setInt(_ parameterIndex: Int, _ x: Int) throws;
    func setDouble(_ parameterIndex: Int, _ x: Double) throws;
    func setString(_ parameterIndex: Int, _ x: String) throws;
}
