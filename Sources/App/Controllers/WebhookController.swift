//
//  WebhookController.swift
//  App
//
//  Created by Steve Goodrich on 11/26/18.
//

import Vapor

final class WebhookController {
 
    func update(_ req: Request) throws -> Future<CommandStatus> {
        return try req.content.decode(MdmEvent.self).map(to:CommandStatus.self) {val in
            if let data64 = val.acknowledge_event?.raw_payload  {

                let decodedString = data64.base64Decoded()
                print("\(decodedString?.replacingOccurrences(of: "\\n", with: "\n") ?? "")")
            }
            let result = CommandStatus(command_uuid: val.acknowledge_event?.command_uuid ?? "", udid: val.acknowledge_event?.udid ?? "")
            return result
        }
    }
}



