//  Environment.swift
//  Created by Václav Brož on 16/10/2022

import Vapor

extension Environment {
    // MARK: - Constants -
    private static let HEROKU_BRANCH_VARIABLE_NAME = "HEROKU_BRANCH"
    private static let DATABASE_URL_VARIABLE_NAME = "DATABASE_URL"
    
    // MARK: - Custom -
    static var staging: Environment {
        .custom(name: "staging")
    }
    
    static var review: Environment {
        .custom(name: "review")
    }
    
    // MARK: - Variables -
    struct Variables {
        static func getDatabaseURL() throws -> URL {
            guard let databaseURLVariableValue = get(Environment.DATABASE_URL_VARIABLE_NAME) else {
                throw VariablesError.missingEnvironmentVariable(name: Environment.DATABASE_URL_VARIABLE_NAME)
            }
            guard let databaseURL = URL(string: databaseURLVariableValue) else {
                throw VariablesError.wrongTypeOfEnvironmentVariable(name: Environment.DATABASE_URL_VARIABLE_NAME)
            }
            return databaseURL
        }
        
        static func getHerokuBranch() throws -> GITBranch {
            guard let herokuBranchVariableValue = get(Environment.HEROKU_BRANCH_VARIABLE_NAME) else {
                throw VariablesError.missingEnvironmentVariable(name: Environment.HEROKU_BRANCH_VARIABLE_NAME)
            }
            return try GITBranch(string: herokuBranchVariableValue)
        }
    }
    
    enum VariablesError: Error {
        case missingEnvironmentVariable(name: String)
        case wrongTypeOfEnvironmentVariable(name: String)
    }
}
