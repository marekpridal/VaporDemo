//
//  RecordTO.swift
//  App
//
//  Created by Marek Pridal on 22.01.19.
//

import FluentMySQL
import Vapor

final class ExchangeRateResponseTO: Model {
    
    /// See `Model.ID`
    typealias ID = String
    
    /// See `Model.idKey`
    static let idKey: IDKey = \.countryCode
    typealias Database = MySQLDatabase
    
    static let entity = "exchange_rates"
    var countryCode: String?
    let value: Float
    let timestamp: Date
    let priority: UInt
    
    init(countryCode: String, value: Float, timestamp: Date, priority: UInt) {
        self.countryCode = countryCode
        self.value = value
        self.timestamp = timestamp
        self.priority = priority
    }
    
    private enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case value
        case timestamp
        case priority
    }
}

extension ExchangeRateResponseTO: Content { }

extension ExchangeRateResponseTO: SQLTable {
    static var sqlTableIdentifierString = "exchange_rates"
}
