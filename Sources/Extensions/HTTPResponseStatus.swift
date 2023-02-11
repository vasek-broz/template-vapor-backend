//  HTTPResponseStatus.swift
//  Created by Václav Brož on 27/11/2022

import Vapor

extension HTTPResponseStatus {
    static let templateCustom: HTTPResponseStatus = .init(statusCode: 419, reasonPhrase: "Template Custom")
}
