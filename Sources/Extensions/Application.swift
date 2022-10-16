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
                connectionString: "mongodb://localhost:27017/template_vapor_backend_development_database"
            ), as: .mongo)
        case .testing:
            try databases.use(.mongo(
                connectionString: "mongodb://localhost:27017/template_vapor_backend_testing_database"
            ), as: .mongo)
        default:
            break
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
}
