//  Application.swift
//  Created by Václav Brož on 15/10/2022.

import Vapor
import Fluent
import FluentPostgresDriver

extension Application {
    // MARK: - Configuration -
    func configure() throws {
        try setupDatabase()
        addMigrations()
        try registerRouteCollections()
        setupMiddlewares()
        if environment == .development {
            try autoMigrate().wait()
        }
    }
    
    private func setupDatabase() throws {
        switch environment {
        case .development, .testing:
            databases.use(.postgres(hostname: "localhost",
                                        username: "username",
                                        password: "password",
                                        database: "database"),
                              as: .psql)
        case .review, .staging, .production:
            let databaseURL = try Environment.Variables.getDatabaseURL()
            guard var postgresConfiguration = PostgresConfiguration(url: databaseURL) else {
                throw ConfigurationError.unableToInitialiazePostgresConfiguration
            }
            var clientTLSConfiguration = TLSConfiguration.makeClientConfiguration()
            clientTLSConfiguration.certificateVerification = .none
            postgresConfiguration.tlsConfiguration = clientTLSConfiguration
            databases.use(.postgres(configuration: postgresConfiguration), as: .psql)
        default:
            throw ConfigurationError.unknownEnvironmentDetected
        }
    }
    
    private func addMigrations() {
        migrations.add(TemplateModelCreationMigration())
    }
    
    private func registerRouteCollections() throws {
        try register(collection: TemplatesRouteCollection())
    }
    
    private func setupMiddlewares() {
        middleware.use(FileMiddleware(publicDirectory: directory.workingDirectory + "/Resources/Public/"))
        if environment == .review || environment == .staging || environment == .production {
            middleware.use(ForceHTTPSMiddleware())
        }
    }
    
    // MARK: - Computed Properties -
    var database: Database {
        db
    }
    
    // MARK: - Nested Types -
    enum ConfigurationError: Error {
        case unknownEnvironmentDetected
        case unableToInitialiazePostgresConfiguration
    }
}
