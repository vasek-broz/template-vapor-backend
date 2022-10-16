//  TemplateModelCreationMigration.swift
//  Created by Václav Brož on 15. 10. 2022

import Fluent

struct TemplateModelCreationMigration: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema("template_models")
            .id()
            .field("template_field", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("template_models").delete()
    }
}
