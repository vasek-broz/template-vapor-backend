//  Environment.swift
//  Created by Václav Brož on 16. 10. 2022

import Vapor

extension Environment {
    static func bootstrap() throws -> Environment {
        .init(name: try Environment.Variables.getEnvironmentName())
    }
    
    // MARK: - Custom -
    static var staging: Environment {
        .custom(name: "staging")
    }
    
    static var developmentReview: Environment {
        .custom(name: "development-review")
    }
    
    static var pullRequestReview: Environment {
        .custom(name: "pull-request-review")
    }
    
    // MARK: - Variables -
    struct Variables {
        static func getDatabaseConnectionString() throws -> String {
            guard let databaseConnectionStringValue = get("DATABASE_CONNECTION_STRING") else {
                throw VariablesError.missingEnvironmentVariable(name: "DATABASE_CONNECTION_STRING")
            }
            return databaseConnectionStringValue
        }
        
        static func getEnvironmentName() throws -> String {
            guard let environmentNameValue = get("ENVIRONMENT_NAME") else {
                throw VariablesError.missingEnvironmentVariable(name: "ENVIRONMENT_NAME")
            }
            return environmentNameValue
        }
        
        static func getHerokuPullRequestNumber() throws -> String {
            guard let herokuPullRequestNumberValue = get("HEROKU_PR_NUMBER") else {
                throw VariablesError.missingEnvironmentVariable(name: "HEROKU_PR_NUMBER")
            }
            return herokuPullRequestNumberValue
        }
    }
    
    enum VariablesError: Error {
        case missingEnvironmentVariable(name: String)
    }
}
