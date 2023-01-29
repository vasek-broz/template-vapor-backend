//  RedisHashEncoder.swift
//  Created by Václav Brož on 29/1/2023.

@testable import Application
import XCTest
import RediStack

final class RedisHashEncoderXCTestCase: XCTestCase {
    // MARK: - Tests -
    func testArrayEncoding() {
        XCTAssertThrowsError(try RedisHashEncoder().encode([ArrayElement()]))
    }
    
    func testObjectWithOptionalFieldsContainingActualValuesIntegerFieldEncoding() throws {
        let redisHashParameters = try RedisHashEncoder().encode(ObjectToEncode.WITH_OPTIONAL_FIELDS_CONTAINING_ACTUAL_VALUES)
        let integerFieldKeyRedisHashParameter = RESPValue(from: ObjectToEncode.CodingKeyes.integerField.rawValue)
        let integerFieldValueRedisHashParameter = RESPValue(from: ObjectToEncode.WITH_OPTIONAL_FIELDS_CONTAINING_ACTUAL_VALUES.integerField)
        
        XCTAssert(redisHashParameters.contains(integerFieldKeyRedisHashParameter))
        let numberOfIntegerFieldKeysInRedisHashParameters = redisHashParameters
            .filter { $0 == integerFieldKeyRedisHashParameter }
            .count
        XCTAssertEqual(numberOfIntegerFieldKeysInRedisHashParameters, 1)
        let indexOfIntegerFieldKeyInRedisHashParameters = redisHashParameters.firstIndex(of: integerFieldKeyRedisHashParameter)!
        XCTAssertEqual(redisHashParameters[indexOfIntegerFieldKeyInRedisHashParameters + 1],
                       integerFieldValueRedisHashParameter)
    }
    
    // TODO: Create complete tests
    
    // MARK: - Nested Types -
    struct ArrayElement: Codable {}
    
    struct ObjectToEncode: Codable {
        static let WITH_OPTIONAL_FIELDS_CONTAINING_ACTUAL_VALUES = ObjectToEncode(integerField: 3824,
                                                                                  optionalIntegerField: 593092,
                                                                                  stringField: "2874rtf87ewshadwoisa",
                                                                                  optinalStringField: "87634ywf98ewohd7834",
                                                                                  booleanField: true,
                                                                                  optionalBooleanField: false,
                                                                                  nestedObjectField: .init(integerField: 2893749832,
                                                                                                           optionalIntegerField: 589784293,
                                                                                                           stringField: "hf2479wjeoiufhd789234",
                                                                                                           optinalStringField: "hf2367rjesd7f489",
                                                                                                           booleanField: false,
                                                                                                           optionalBooleanField: true),
                                                                                  optionalNestedObjectField: .init(integerField: 8234,
                                                                                                                   optionalIntegerField: 3,
                                                                                                                   stringField: "fsiou",
                                                                                                                   optinalStringField: "4738",
                                                                                                                   booleanField: true,
                                                                                                                   optionalBooleanField: false))
        
        static let EXAMPLE_WITHOUT_OPTIONAL_VALUES = ObjectToEncode(integerField: 3824,
                                                                    optionalIntegerField: 593092,
                                                                    stringField: "2874rtf87ewshadwoisa",
                                                                    optinalStringField: "87634ywf98ewohd7834",
                                                                    booleanField: true,
                                                                    optionalBooleanField: false,
                                                                    nestedObjectField: .init(integerField: 8234,
                                                                                             optionalIntegerField: 3,
                                                                                             stringField: "fsiou",
                                                                                             optinalStringField: "4738",
                                                                                             booleanField: true,
                                                                                             optionalBooleanField: false),
                                                                    optionalNestedObjectField: nil)
        
        let integerField: Int
        let optionalIntegerField: Int?
        let stringField: String
        let optinalStringField: String?
        let booleanField: Bool
        let optionalBooleanField: Bool?
        let nestedObjectField: NestedObjectToEncode
        let optionalNestedObjectField: NestedObjectToEncode?
        
        enum CodingKeyes: String, CodingKey {
            case integerField
            case optionalIntegerField
            case stringField
            case optinalStringField
            case booleanField
            case optionalBooleanField
            case nestedObjectField
            case optionalNestedObjectField
        }
        
        struct NestedObjectToEncode: Codable {
            let integerField: Int
            let optionalIntegerField: Int
            let stringField: String
            let optinalStringField: String?
            let booleanField: Bool
            let optionalBooleanField: Bool
        }
    }
}
