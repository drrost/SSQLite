//
//  ResultSet.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public protocol ResultSet {

    func getInt(_ columnIndex: Int) throws -> Int;
    func getDouble(_ columnIndex: Int) throws -> Double;
    func getString(_ columnIndex: Int) throws -> String;
    func getBool(_ columnIndex: Int) throws -> Bool;
}
