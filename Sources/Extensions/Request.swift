//  Request.swift
//  Created by Václav Brož on 15/10/2022

import Vapor
import FluentKit

extension Request {
    // MARK: - Computed Properties -
    var database: Database {
        db
    }
}
