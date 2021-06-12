import Vapor

/// Register your application's routes here.
public func routes(_ app: Application) throws {
    app.get("name") { _ in
        return "Ethan Hunt"
    }

    app.get("json") { (_) in
        return PersonTO(name: "John", surname: "Appleseed", age: 10, height: 198.2, value: 10.10)
    }

    app.get("loop") { (_) -> String in
        //while true { print("Loop") }
        return "NOT in production"
    }
    
    app.get("requestDebugDescription") { (request) -> String in
        return request.description
    }

    let exchangeRatesController = ExchangeRatesController()
    app.get("exchanges", use: exchangeRatesController.list)
    app.get("exchangeRate", use: exchangeRatesController.exchangeRate)
    app.post("exchange", use: exchangeRatesController.insertExchangeRate)
    app.put("exchange", use: exchangeRatesController.updateExchangeRate)
    app.delete("exchange", use: exchangeRatesController.deleteExchangeRate)

    let viewController = ViewController()
    app.get("", use: viewController.welcomeView)
}
