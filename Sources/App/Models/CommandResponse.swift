//
//  CommandStatus.swift
//  App
//
//  Created by Steve Goodrich on 11/30/18.
//

import Foundation
import FluentSQLite

struct CommandResponse: Codable {
    struct CommandInfo: Codable {
        var command_uuid: String
        var command: [String: String]
    }
    var payload: CommandInfo
}
