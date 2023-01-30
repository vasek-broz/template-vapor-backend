//  RedisHashEncoder.swift
//  Created by Václav Brož on 29/1/2023.

@testable import Application
import XCTest
import RediStack

final class RedisHashEncoderXCTestCase: XCTestCase {
    // MARK: - Constants -
    private static let SINGLE_VALUE = "single value"
    private static let OBJECT_WITH_PROPERTY_OF_OBJECT_TYPE = ObjectWithPropertyOfObjectType(propertyOfObjectType: .init(property: "property"))
    private static let OBJECT = Object(integerProperty: 3647,
                                       optionalIntegerProperty: nil,
                                       stringProperty: "property",
                                       optinalStringProperty: nil,
                                       booleanProperty: true,
                                       optionalBooleanProperty: nil,
                                       stringCodableObjectProperty: .init(property: "string codable object property"),
                                       optionalstringCodableObjectProperty: nil)
    
    // MARK: - Tests -
    func testArrayEncoding() {
        XCTAssertThrowsError(try RedisHashEncoder().encode([ArrayElement()]))
    }
    
    func testSingleValueEncoding() {
        XCTAssertThrowsError(try RedisHashEncoder().encode(RedisHashEncoderXCTestCase.SINGLE_VALUE))
    }
    
    func testObjectWithPropertyOfObjectTypeEncoding() {
        XCTAssertThrowsError(try RedisHashEncoder().encode(RedisHashEncoderXCTestCase.OBJECT_WITH_PROPERTY_OF_OBJECT_TYPE))
    }
    
    func testObjectEncoding() {
        XCTAssertNoThrow(try RedisHashEncoder().encode(RedisHashEncoderXCTestCase.OBJECT))
        // TODO: Complete this test
    }
    
    // MARK: - Nested Types -
    private struct ArrayElement: Codable {}
    
    private struct ObjectWithPropertyOfObjectType: Codable {
        let propertyOfObjectType: Object
        
        struct Object: Codable {
            let property: String
        }
    }
    
    private struct Object: Codable {
        let integerProperty: Int
        let optionalIntegerProperty: Int?
        let stringProperty: String
        let optinalStringProperty: String?
        let booleanProperty: Bool
        let optionalBooleanProperty: Bool?
        let stringCodableObjectProperty: StringCodableObject
        let optionalstringCodableObjectProperty: StringCodableObject?
        
        struct StringCodableObject: StringCodable {
            let property: String
            
            init(property: String) {
                self.property = property
            }
            
            init?(from string: String) {
                property = string
            }
            
            var string: String {
                property
            }
            
            var description: String {
                property
            }
        }
    }
}
