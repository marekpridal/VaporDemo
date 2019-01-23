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
        return req.withPooledConnection(to: .mysql) { (conn: MySQLConnection) -> EventLoopFuture<[ExchangeRateResponseTO]> in
            return conn
                .select()
                .all()
                .from(ExchangeRateResponseTO.self)
                .all(decoding: ExchangeRateResponseTO.self)
        }
    }
    
    func exchangeRate(_ req: Request) throws -> Future<ExchangeRateResponseTO> {
        let requestObject = try! req.query.decode(ExchangeRateRequestTO.self)
        return req.withPooledConnection(to: .mysql) { (conn: MySQLConnection) -> EventLoopFuture<ExchangeRateResponseTO> in
            return conn
                .select()
                .all()
                .from(ExchangeRateResponseTO.self)
                .where(\ExchangeRateResponseTO.countryCode == requestObject.countryCode)
                .first(decoding: ExchangeRateResponseTO.self)
                .unwrap(or: Abort.init(.notFound))
            }
    }
}
