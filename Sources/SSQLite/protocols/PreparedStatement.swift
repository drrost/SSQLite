//
//  PreparedStatement.swift
//  A part of git@github.com:drrost/SSQLite.git project
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public protocol PreparedStatement: Statement {

    func executeUpdate() throws -> Int32

    func setNull(_ parameterIndex: Int, _ sqlType: Int) throws
    func setBoolean(_ parameterIndex: Int, _ x: Bool) throws
    func setInt(_ parameterIndex: Int, _ x: Int) throws
    func setDouble(_ parameterIndex: Int, _ x: Double) throws
    func setString(_ parameterIndex: Int, _ x: String) throws
}
