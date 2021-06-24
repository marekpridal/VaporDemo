//
//  ViewController.swift
//  App
//
//  Created by Marek Přidal on 25/01/2019.
//

import Vapor

final class ViewController {
    func welcomeView(_ req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("Welcome")
    }
}
