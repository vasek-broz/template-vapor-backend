//  StringCodable.swift
//  Created by Václav Brož on 30/1/2023.

protocol StringCodable: CustomStringConvertible, Codable {
    init?(from string: String)
    var string: String { get }
}
