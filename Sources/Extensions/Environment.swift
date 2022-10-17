//  Environment.swift
//  Created by Václav Brož on 16. 10. 2022

import Vapor

extension Environment {
    // MARK: - Custom -
    static var staging: Environment {
        .custom(name: "staging")
    }
    
    static var review: Environment {
        .custom(name: "review")
    }
    
    // MARK: - Variables -
    struct Variables {
        static func getDatabaseConnectionString() throws -> String {
            guard let databaseConnectionStringValue = get("DATABASE_CONNECTION_STRING") else {
                throw VariablesError.missingEnvironmentVariable(name: "DATABASE_CONNECTION_STRING")
            }
            return databaseConnectionStringValue
        }
        
        static func getHerokuAppName() throws -> String {
            guard let herokuAppNameValue = get("HEROKU_APP_NAME") else {
                throw VariablesError.missingEnvironmentVariable(name: "HEROKU_APP_NAME")
            }
            return herokuAppNameValue
        }
    }
    
    enum VariablesError: Error {
        case missingEnvironmentVariable(name: String)
    }
}
