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
        //while true { print("Loop") }
        return "NOT in production"
    }
    
    router.get("requestDebugDescription") { (request) -> String in
        return request.debugDescription
    }

    let exchangeRatesController = ExchangeRatesController()
    router.get("exchanges", use: exchangeRatesController.list)
    router.get("exchangeRate", use: exchangeRatesController.exchangeRate)
    router.post("exchange", use: exchangeRatesController.insertExchangeRate)
    router.put("updateExchangeRate", use: exchangeRatesController.updateExchangeRate)
    router.delete("deleteExchangeRate", use: exchangeRatesController.deleteExchangeRate)

    let viewController = ViewController()
    router.get("/", use: viewController.welcomeView)
}
