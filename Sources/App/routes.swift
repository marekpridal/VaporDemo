import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("name") { _ in
        return "Ethan Hunt"
    }
    
    router.get("json") { (_) in
        return PersonTO(name: "John", surname: "Appleseed", age: 10, height: 198.2, value: 10.10)
    }
    
    router.get("loop") { (_) -> String in
        while true { print("Loop") }
        return "true"
    }
    
    let exchangeRatesController = ExchangeRatesController()
    router.get("exchanges", use: exchangeRatesController.list)
    router.get("exchangeRate", use: exchangeRatesController.exchangeRate)
}
