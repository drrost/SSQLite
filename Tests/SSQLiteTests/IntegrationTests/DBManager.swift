//
//  DBManager.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation
import RDError
import ExtensionsFoundation
import SSQLite

class DBManager {

    let dst: String

    init() {
        dst = DBManager.getDstPath()
    }

    func connect() throws -> Connection {
        if FileManager.exists(dst) == false {
            try createDbFile()
        }
        return try DriverManager.getConnection(dst)
    }

    func erase() throws {
        let dirPath = (dst as NSString).deletingLastPathComponent
        try FileManager.delete(dirPath)
    }

    private static func getDstPath() -> String {
        #if os(iOS)
        let path = FileManager.getDocumentsDirectory()
        #else // macOS
        let path = FileManager.default.currentDirectoryPath
        #endif

        return path.appendingPathComponent("db").appendingPathComponent("db.sqlite")
    }

    private func createDbFile() throws {
        try FileManager.createFile(dst)
    }
}
