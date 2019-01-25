//
//  ViewController.swift
//  App
//
//  Created by Marek Přidal on 25/01/2019.
//

import Vapor

final class ViewController {
    func welcomeView(_ req: Request) throws -> Future<View> {
        return try req.view().render("Welcome")
    }
}
