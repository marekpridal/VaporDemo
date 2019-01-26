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
        guard let requestObject = try? req.query.decode(ExchangeRateRequestTO.self) else {
            throw Abort(.badRequest)
        }
        return ExchangeRateResponseTO.find(requestObject.countryCode, on: req).unwrap(or: Abort.init(.notFound))
    }

    func insertExchangeRate(_ req: Request) throws -> Future<ExchangeRateResponseTO> {
        return try req.content.decode(ExchangeRateResponseTO.self).flatMap { rate in
            ExchangeRateResponseTO.find(rate.countryCode ?? "", on: req).map({ existing in return (rate, existing != nil) }).flatMap({ (rate, exists) -> EventLoopFuture<ExchangeRateResponseTO> in
                    guard !exists else { throw Abort(.conflict) }
                    return rate.create(on: req)
                })
        }
    }

    func deleteExchangeRate(_ req: Request) throws -> Future<HTTPResponseStatus> {
        return try req.content.decode(ExchangeRateResponseTO.self).flatMap({ rate in
            ExchangeRateResponseTO.find(rate.countryCode ?? "", on: req).unwrap(or: Abort.init(.notFound)).flatMap({ (rate: ExchangeRateResponseTO) -> (EventLoopFuture<HTTPResponseStatus>) in
                return rate
                    .delete(on: req)
                    .map { _ -> HTTPResponseStatus in return HTTPResponseStatus.accepted }
            })
        })
    }

    func updateExchangeRate(_ req: Request) throws -> Future<ExchangeRateResponseTO> {
        return try req.content.decode(ExchangeRateResponseTO.self).flatMap({ rate in
            ExchangeRateResponseTO.find(rate.countryCode ?? "", on: req).unwrap(or: Abort.init(.notFound)).flatMap({ (rate) -> (EventLoopFuture<(ExchangeRateResponseTO)>) in
                return rate.update(on: req)
            })
        })
    }
}
