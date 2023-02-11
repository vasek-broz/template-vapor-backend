//  Executable.swift
//  Created by Václav Brož on 15/10/2022

import Vapor

@main struct Executable {
    static func main() async throws {
        var environment = try Environment.detect()
        try LoggingSystem.bootstrap(from: &environment)
        let application = Application(environment)
        defer { application.shutdown() }
        try application.configure()
        if environment == .development {
            try await application.autoMigrate()
        }
        try application.run()
    }
}
