//
//  SQLException.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.02.2021.
//

import Foundation
import RDError

public class SQLException: RDError {

    public let reason: String
    public let SQLState: String?

    public init(
        _ reason: String,
        detailed: String? = nil,
        _ SQLState: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line) {

        self.reason = reason
        self.SQLState = SQLState
        super.init(reason, detailed: detailed ?? "", file: file, line: line)
    }
}
