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
        try databases.use(.mongo(
            connectionString: "mongodb://localhost:27017/vapor_database"
        ), as: .mongo)
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
