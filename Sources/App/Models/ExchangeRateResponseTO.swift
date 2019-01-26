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
    let value: Double
    let timestamp: Date
    let priority: UInt
    
    init(countryCode: String, value: Double, timestamp: Date?, priority: UInt) {
        self.countryCode = countryCode
        self.value = value
        self.timestamp = timestamp ?? Date()
        self.priority = priority
    }
    
    private enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case value
        case timestamp
        case priority
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.countryCode = try container.decode(String.self, forKey: .countryCode)
            self.value = try container.decode(Double.self, forKey: .value)
            self.timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp) ?? Date()
            self.priority = try container.decode(UInt.self, forKey: .priority)
        } catch let e {
            print(e)
            throw e
        }
    }
}

extension ExchangeRateResponseTO: Content { }

extension ExchangeRateResponseTO: MySQLMigration { }

extension ExchangeRateResponseTO: SQLTable {
    static var sqlTableIdentifierString = "exchange_rates"
}
