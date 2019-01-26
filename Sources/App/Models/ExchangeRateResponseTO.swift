//
//  RecordTO.swift
//  App
//
//  Created by Marek Pridal on 22.01.19.
//

import FluentMySQL
import Vapor

final class ExchangeRateResponseTO: Model {
    /// Table name
    static let entity = "exchange_rates"

    /// See `Model.ID`
    typealias ID = String

    /// Database type
    typealias Database = MySQLDatabase

    /// See `Model.idKey`
    static let idKey: IDKey = \.countryCode

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

extension ExchangeRateResponseTO: MySQLMigration {
    /**
     If table already exists, implement this method for first migration to create fluent table and enabling automatic migration.
     After first migration disable it, it should work OK 🙂
     */
    /*
    static func prepare(on conn: MySQLConnection) -> Future<Void> {
         return conn.future()
    }
     */
}

extension ExchangeRateResponseTO: SQLTable {
    static var sqlTableIdentifierString = "exchange_rates"
}
