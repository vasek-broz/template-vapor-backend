//  ForceHTTPS.swift
//  Created by Václav Brož on 27/11/2022.

import Vapor

struct ForceHTTPSMiddleware: AsyncMiddleware {
    func respond(to request: Vapor.Request, chainingTo asyncResponder: Vapor.AsyncResponder) async throws -> Vapor.Response {
        guard request.headers.first(name: "X-Forwarded-Proto") == "https" else {
            guard let requestHost = request.headers.first(name: "host") else {
                throw Abort(.internalServerError)
            }
            let httpsURL = "https://\(requestHost)\(request.url.path)"
            return request.redirect(to: httpsURL)
        }
        return try await asyncResponder.respond(to: request)
    }
}
