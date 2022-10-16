//  Application.swift
//  Created by Václav Brož on 15. 10. 2022

import Vapor
import Fluent
import FluentMongoDriver

extension Application {
    // MARK: - Configuration -
    func configure() throws {
        middleware.use(FileMiddleware(publicDirectory: directory.workingDirectory + "/Resources/Public/"))
        try setupDatabase()
        addMigrations()
        try registerRouteCollections()
    }
    
    private func setupDatabase() throws {
        switch environment {
        case .development:
            try databases.use(.mongo(
                connectionString: "mongodb://localhost:27017/template-vapor-be-development-database"
            ), as: .mongo)
        case .testing:
            try databases.use(.mongo(
                connectionString: "mongodb://localhost:27017/template-vapor-be-testing-database"
            ), as: .mongo)
        case .review:
            try databases.use(.mongo(
                connectionString: "\(Environment.Variables.getDatabaseConnectionString())/\(Environment.Variables.getHerokuAppName())-database"
            ), as: .mongo)
        case .staging:
            try databases.use(.mongo(
                connectionString: "\(Environment.Variables.getDatabaseConnectionString())/template-vapor-be-staging-database"
            ), as: .mongo)
        case .production:
            try databases.use(.mongo(
                connectionString: "\(Environment.Variables.getDatabaseConnectionString())/template-vapor-be-production-database"
            ), as: .mongo)
        default:
            throw ConfigurationError.unknownEnvironmentDetected
        }
    }
    
    private func addMigrations() {
        migrations.add(TemplateModelCreationMigration())
    }
    
    private func registerRouteCollections() throws {
        try register(collection: TemplateController())
    }
    
    // MARK: - Database -
    var database: Database {
        db
    }
    
    // MARK: - Nested Types -
    enum ConfigurationError: Error {
        case unknownEnvironmentDetected
    }
}
