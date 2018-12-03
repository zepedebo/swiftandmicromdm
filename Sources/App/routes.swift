import Vapor

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        var st = self;
        if (self.count % 4 <= 2){
            st += String(repeating: "=", count: (self.count % 4))
        }
        guard let data = Data(base64Encoded: st) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
//    router.get { req in
//        return try req.view().render("main")
//    }
//
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    let webHookController = WebhookController()
    router.post("webhooks", use:webHookController.update)
    
    let mainController = MainController()
    router.get("/", use: mainController.mainForm)
    router.post("command", use:mainController.sendCommand)



    
}
