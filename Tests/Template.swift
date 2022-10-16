//  Template.swift
//  Created by Václav Brož on 15. 10. 2022

@testable import App
import XCTVapor

final class TemplateTests: XCTestCase {
    func testGettingAllTemplates() async throws {
        let application = Application(.testing)
        defer { application.shutdown() }
        try application.configure()
        
        try await TemplateModel(templateField: "first").save(on: application.database)
        try await TemplateModel(templateField: "second").save(on: application.database)
        
        try application.test(.GET, "template/all", afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            let decodedResponseContent = try response.content.decode([TemplateModel].self)
            XCTAssertEqual(decodedResponseContent.count, 2)
            XCTAssertEqual(decodedResponseContent[0].templateField, "first")
            XCTAssertEqual(decodedResponseContent[1].templateField, "second")
        })
    }
}
