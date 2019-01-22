import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("name") { req in
        return "Ethan Hunt"
    }
    
    router.get("json") { (request) in
        return PersonTO(name: "John", surname: "Appleseed", age: 10, height: 198.2, value: 10.10)
    }
}
