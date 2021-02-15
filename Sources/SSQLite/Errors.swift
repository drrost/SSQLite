//
//  File.swift
//  
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation

public class SQLException: Error {

    public let reason: String
    public let SQLState: String?

    public init(_ reason: String, _ SQLState: String? = nil) {
        self.reason = reason
        self.SQLState = SQLState
    }
}
