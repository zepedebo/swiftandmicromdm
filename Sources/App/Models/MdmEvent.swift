//
//  MdmEvent.swift
//  App
//
//  Created by Steve Goodrich on 11/26/18.
//

import Vapor

final class MdmEvent: Content {
    struct AcknoledgeEvent : Codable {
        var udid: String = ""
        var status: String = ""
        var command_uuid: String?
        var url_params: String?
        var raw_payload: String?
    }
    
    struct CheckinEvent: Codable {
        var udid: String = ""
        var url_params: String = ""
        var raw_payload: String = ""
    }
    var topic: String = ""
    var event_id: String = ""
    var created_at: String = ""
    var checkin_event: CheckinEvent?
    var acknowledge_event: AcknoledgeEvent?
    
}

