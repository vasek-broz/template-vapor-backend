//  Application.swift
//  Created by Václav Brož on 15. 10. 2022

import Vapor
import Fluent
import FluentMongoDriver

extension Application {
    public func configure() throws {
        useResourcesPublicDirectoryFileMiddleware()

        try databases.use(.mongo(
            connectionString: Environment.get("DATABASE_URL") ?? "mongodb://localhost:27017/vapor_database"
        ), as: .mongo)
        
        migrations.add(CreateTodo())
        
        get("") { req async in
            "It works!"
        }

        get("hello") { req async -> String in
            "Hello, world!"
        }

        try register(collection: TodoController())
    }
    
    private func useResourcesPublicDirectoryFileMiddleware() {
        middleware.use(FileMiddleware(publicDirectory: directory.workingDirectory + "/Resources/Public/"))
    }
}
