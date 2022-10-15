//  Template.swift
//  Created by Václav Brož on 15. 10. 2022

import Fluent
import BSON
import Vapor

final class TemplateModel: Model, Content {
    // MARK: - Schema -
    static let schema = "template_models"
    
    // MARK: - ID -
    @ID(custom: .id)
    var id: ObjectId?

    // MARK: - Fields -
    @Field(key: "template_field")
    var templateField: String

    // MARK: - Initialiazers -
    init() { }
    
    init(templateField: String) {
        self.templateField = templateField
    }
}
