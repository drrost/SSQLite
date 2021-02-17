//
//  ResultSet.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public protocol ResultSet {

    func next() throws -> Bool
    func getInt(_ columnLabel: String) throws -> Int
    func getDouble(_ columnLabel: String) throws -> Double
    func getString(_ columnLabel: String) throws -> String
    func getBool(_ columnLabel: String) throws -> Bool
}
