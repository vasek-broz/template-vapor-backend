//  Template.swift
//  Created by Václav Brož on 15/10/2022.

import Fluent
import Vapor

final class TemplateModel: Model {
    // MARK: - Schema -
    static let schema = "template_models"
    
    // MARK: - ID -
    @ID(key: .id)
    var id: UUID?

    // MARK: - Fields -
    @Field(key: "template_field")
    var templateField: String

    // MARK: - Initialiazers -
    init() {}
    
    init(templateField: String) {
        self.templateField = templateField
    }
}

// MARK: - Content Conformance -
extension TemplateModel: Content {}
