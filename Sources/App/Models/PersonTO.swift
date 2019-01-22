//
//  PersonTO.swift
//  App
//
//  Created by Marek Pridal on 22.01.19.
//

import Foundation
import Vapor

struct PersonTO: Content {
    let name: String
    let surname: String
    let age: Int
    let height: Double
    let value: Decimal
}
