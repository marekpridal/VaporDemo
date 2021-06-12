//
//  RecordTO.swift
//  App
//
//  Created by Marek Pridal on 22.01.19.
//

import Fluent
import FluentMySQLDriver
import Vapor

final class ExchangeRateResponseTO: Model, Content {
    /// Table name
    static let schema = "exchange_rates"

    @ID(custom: "country_code")
    var id: String?

    @Field(key: "value")
    var value: Double
    @Field(key: "timestamp")
    var timestamp: Date
    @Field(key: "priority")
    var priority: UInt
    
    var countryCode: String? {
        get {
            id
        }
        set {
            id = newValue
        }
    }
    
    init() { }

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
    
    func update(newValue: ExchangeRateResponseTO) -> Self {
        self.value = newValue.value
        self.timestamp = newValue.timestamp
        self.priority = newValue.priority
        return self
    }
}

//extension ExchangeRateResponseTO: Content { }

extension ExchangeRateResponseTO: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database
            .schema(Self.schema)
            .field("country_code", .string, .required)
            .field("value", .double, .required)
            .field("timestamp", .datetime, .required)
            .field("priority", .uint, .required)
            .unique(on: "country_code")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Self.schema).delete()
    }
}
