//
//  CommandStatus.swift
//  App
//
//  Created by Steve Goodrich on 11/30/18.
//
import Vapor
import Foundation
import FluentSQLite

final class CommandStatus : SQLiteModel {
    var id: Int?
    var command_uuid: String
    var udid: String
    var status: String
    var raw_payload: String?
    
    init(id: Int? = nil, command_uuid: String, udid: String) {
        self.id = id
        self.command_uuid = command_uuid
        self.udid = udid
        self.status = "pending"
    }

    
}

/// Allows `Todo` to be used as a dynamic migration.
extension CommandStatus: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension CommandStatus: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension CommandStatus: Parameter { }
