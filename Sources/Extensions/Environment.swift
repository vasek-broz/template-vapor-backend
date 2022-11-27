//  Environment.swift
//  Created by Václav Brož on 16/10/2022.

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
        static func getDatabaseURL() throws -> URL {
            guard let databaseURLVariableValue = get("DATABASE_URL") else {
                throw VariablesError.missingEnvironmentVariable(name: "DATABASE_URL")
            }
            guard let databaseURL = URL(string: databaseURLVariableValue) else {
                throw VariablesError.wrongTypeOfEnvironmentVariable(name: "DATABASE_URL")
            }
            return databaseURL
        }
    }
    
    enum VariablesError: Error {
        case missingEnvironmentVariable(name: String)
        case wrongTypeOfEnvironmentVariable(name: String)
    }
}
