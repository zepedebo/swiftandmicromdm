//
//  Main.swift
//  App
//
//  Created by Steve Goodrich on 11/30/18.
//

import Vapor

struct Command: Content {
    var udid: String = ""
    var request_type: String = ""
}

class Delegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
}


func buildCredential(username: String, password: String) -> String {
    let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
    return loginData.base64EncodedString()
}

let q = OperationQueue()
func request(urlString: String, command: Command, req: Request) throws {
    
    
    guard let url = URL(string: urlString) else {
        return
    }
    
    // create the request
    
    
    
    
    var request = URLRequest(url: url)
    request.httpBody = try? JSONEncoder().encode(command)
    request.httpMethod = "POST"
    request.setValue("Basic \(buildCredential(username: "micromdm", password: "overlord"))", forHTTPHeaderField: "Authorization")



    let config = URLSessionConfiguration.default

    config.httpAdditionalHeaders = ["User-Agent":"micromdmtest"]

    let session = URLSession(configuration: config, delegate: Delegate(), delegateQueue: q)

    session.dataTask(with: request) {(data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        }
        guard let data = data else { return }
        do {
            let devices = try JSONDecoder().decode(CommandResponse.self, from: data)
            print("\(devices)")

        } catch {
            print(error.localizedDescription)
            print(String(data: data, encoding: .utf8))
        }
        }.resume()
}


final class MainController {
    func mainForm(_ req: Request) throws -> Future<View> {
        return try req.view().render("main")
    }
    
    func sendCommand(_ req: Request) throws -> EventLoopFuture<Response> {
        struct CommandString: Content {
            var command: String
        }
        return try req.content.decode(CommandString.self).map {command -> Response in
            try request(urlString: "https://slc-steveg-sierra.eng.landesk.com/v1/commands", command: Command(udid: "20914949-BB0A-5787-B432-3474DD2B2027", request_type: command.command), req: req)
            return req.redirect(to: "/")
        }
        
    }
}
