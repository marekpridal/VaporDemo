//
//  ExchangeRatesController.swift
//  App
//
//  Created by Marek Pridal on 22.01.19.
//

import Vapor
import FluentMySQLDriver

final class ExchangeRatesController {
    func list(_ req: Request) -> EventLoopFuture<[ExchangeRateResponseTO]> {
        return ExchangeRateResponseTO.query(on: req.db).all()
    }

    func exchangeRate(_ req: Request) throws -> EventLoopFuture<ExchangeRateResponseTO> {
        let requestObject = try req.query.decode(ExchangeRateRequestTO.self)
        return ExchangeRateResponseTO.find(requestObject.countryCode, on: req.db).unwrap(or: Abort.init(.notFound))
    }

    func insertExchangeRate(_ req: Request) throws -> EventLoopFuture<ExchangeRateResponseTO> {
        let request = try req.content.decode(ExchangeRateResponseTO.self)
        
        return ExchangeRateResponseTO
                .find(request.countryCode, on: req.db)
                .guard({ $0 == nil }, else: Abort(.conflict))
                .flatMap { _ in
                    return request.save(on: req.db).flatMap { _ in
                        ExchangeRateResponseTO.find(request.countryCode, on: req.db).unwrap(or: Abort(.internalServerError))
                    }
                }
    }

    func deleteExchangeRate(_ req: Request) throws -> EventLoopFuture<HTTPResponseStatus> {
        let request = try req.content.decode(ExchangeRateResponseTO.self)
        
        return ExchangeRateResponseTO.find(request.countryCode, on: req.db).unwrap(or: Abort(.notFound)).flatMap { rate in
            rate.delete(on: req.db).transform(to: HTTPResponseStatus.accepted)
        }
    }

    func updateExchangeRate(_ req: Request) throws -> EventLoopFuture<ExchangeRateResponseTO> {
        let request = try req.content.decode(ExchangeRateResponseTO.self)
        
        return ExchangeRateResponseTO.find(request.countryCode, on: req.db).unwrap(or: Abort(.notFound)).flatMap { exchangeRate in
            exchangeRate.update(newValue: request).update(on: req.db).transform(to: request)
        }
    }
}
