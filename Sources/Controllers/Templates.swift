//  Templates.swift
//  Created by Václav Brož on 15. 10. 2022

import Fluent
import Vapor

struct TemplateController: RouteCollection {
    // MARK: - Boot -
    func boot(routes: RoutesBuilder) throws {
        let templateRoute = routes.grouped("template")
        templateRoute.get("all", use: getAllTemplates)
    }

    // MARK: - Handlers -
    func getAllTemplates(request: Request) async throws -> [TemplateModel] {
        try await TemplateModel.query(on: request.database).all()
    }
}
