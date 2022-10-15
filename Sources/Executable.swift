//  Executable.swift
//  Created by Václav Brož on 15. 10. 2022

import Vapor

@main struct Executable {
    static func main() throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        let app = Application(env)
        defer { app.shutdown() }
        try app.configure()
        try app.run()
    }
}
