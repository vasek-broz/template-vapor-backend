//  Templates.swift
//  Created by Václav Brož on 15/10/2022.

@testable import Application
import XCTVapor
import Fluent

final class TemplatesRouteCollectionTests: XCTestCase {
    // MARK: - Properties -
    let application: Application = .init(.testing)
    
    // MARK: - Lifecycle -
    override func setUp() async throws {
        try application.configure()
        // TODO: Try using XCTFluent instead of actual database
        application.migrations.add(DatabasePopulationMigration())
        try await application.autoMigrate()
    }
    
    override func tearDown() {
        application.shutdown()
    }
    
    // MARK: - Tests -
    func testGettingAllTemplates() async throws {        
        try application.test(.GET, "templates", afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            let decodedResponseContent = try response.content.decode([TemplateModel].self)
            XCTAssertEqual(decodedResponseContent.count, 2)
            XCTAssertEqual(decodedResponseContent[0].templateField, "first")
            XCTAssertEqual(decodedResponseContent[1].templateField, "second")
        })
    }
    
    
    // MARK: - Nested Types -
    struct DatabasePopulationMigration: AsyncMigration {
        func prepare(on database: FluentKit.Database) async throws {
            try await TemplateModel(templateField: "first").save(on: database)
            try await TemplateModel(templateField: "second").save(on: database)
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await TemplateModel.query(on: database).group(.or) { group in
                group.filter(\.$templateField == "first").filter(\.$templateField == "second")
            }
            .all()
            .delete(on: database)
        }
    }
}
