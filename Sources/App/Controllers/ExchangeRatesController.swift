//
//  ExchangeRatesController.swift
//  App
//
//  Created by Marek Pridal on 22.01.19.
//

import Vapor
import FluentMySQL
import MySQL

final class ExchangeRatesController {
    func list(_ req: Request) -> Future<[ExchangeRateResponseTO]> {
        return ExchangeRateResponseTO.query(on: req).all()
    }
    
    func exchangeRate(_ req: Request) throws -> Future<ExchangeRateResponseTO> {
        let requestObject = try! req.query.decode(ExchangeRateRequestTO.self)
        return ExchangeRateResponseTO.find(requestObject.countryCode, on: req).unwrap(or: Abort.init(.notFound))
    }
    
    func insertExchangeRate(_ req: Request) throws -> Future<ExchangeRateResponseTO> {
        return try req.content.decode(ExchangeRateResponseTO.self).flatMap { rate in
            return rate.create(on: req).map({ (result) in
                return result
            })
        }
    }
    
    func deleteExchangeRate(_ req: Request) throws -> Future<HTTPResponseStatus> {
        return try req.content.decode(ExchangeRateResponseTO.self).flatMap({ rate in
            return rate.delete(on: req).map { HTTPResponseStatus.accepted }
        })
    }
    
    func updateExchangeRate(_ req: Request) throws -> Future<ExchangeRateResponseTO> {
        return try req.content.decode(ExchangeRateResponseTO.self).flatMap({ rate in
            return rate.update(on: req)
        })
    }
}
