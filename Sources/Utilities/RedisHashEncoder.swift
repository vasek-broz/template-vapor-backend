//  RedisHashEncoder.swift
//  Created by Václav Brož on 29/1/2023.

import RediStack

// MARK: - RedisHashEncoder -
struct RedisHashEncoder {
    func encode<T: Encodable>(_ value: T) throws -> [RESPValue] {
        let redisHashEncoder = _RedisHashEncoder()
        try value.encode(to: redisHashEncoder)
        return redisHashEncoder.output
    }
    
    enum EncodingError: Error, CustomStringConvertible {
        case objectContainingArray
        
        var description: String {
            switch self {
            case .objectContainingArray:
                return "Object to encode contains array which is not supported in Redis hash data type."
            }
        }
    }
}

// MARK: - _RedisHashEncoder -
fileprivate struct _RedisHashEncoder {
    private let encodedContent: EncodedContent
    let codingPath: [CodingKey]

    var output: [RESPValue] {
        encodedContent.stringKeyValuePairs.reduce([]) { partialResult, keyValuePair in
            partialResult + [RESPValue(from: keyValuePair.key), RESPValue(from: keyValuePair.value)]
        }
    }
    
    init(encodedContent: EncodedContent = .init(), codingPath: [CodingKey] = []) {
        self.encodedContent = encodedContent
        self.codingPath = codingPath
    }

    final class EncodedContent {
        private(set) var stringKeyValuePairs: [String: String] = [:]

        func insert(value: String, at codingKeys: [CodingKey]) {
            let key = codingKeys.map { $0.stringValue }.joined(separator: ".")
            stringKeyValuePairs[key] = value
        }
    }
}

extension _RedisHashEncoder: Encoder {
    var userInfo: [CodingUserInfoKey : Any] {
        [:]
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let redisHashKeyedEncodingContainer = _RedisHashKeyedEncodingContainer<Key>(encodedContent: encodedContent,
                                                                                    codingPath: codingPath)
        return KeyedEncodingContainer(redisHashKeyedEncodingContainer)
    }

    func unkeyedContainer() -> Swift.UnkeyedEncodingContainer {
        _RedisHashUnkeyedEncodingContainer()
    }

    func singleValueContainer() -> Swift.SingleValueEncodingContainer {
        _RedisHashSingleValueEncodingContainer(encodedContent: encodedContent, codingPath: codingPath)
    }
}

// MARK: - _RedisHashKeyedEncodingContainer -
fileprivate struct _RedisHashKeyedEncodingContainer<Key: CodingKey> {
    private let encodedContent: _RedisHashEncoder.EncodedContent
    let codingPath: [CodingKey]
    
    init(encodedContent: _RedisHashEncoder.EncodedContent, codingPath: [CodingKey]) {
        self.encodedContent = encodedContent
        self.codingPath = codingPath
    }
}

extension _RedisHashKeyedEncodingContainer: KeyedEncodingContainerProtocol {
    mutating func encodeNil(forKey key: Key) throws {
        encodedContent.insert(value: "null", at: codingPath + [key])
    }

    mutating func encode(_ value: Bool, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: String, forKey key: Key) throws {
        encodedContent.insert(value: value, at: codingPath + [key])
    }

    mutating func encode(_ value: Double, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: Float, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: Int, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: Int8, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: Int16, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: Int32, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: Int64, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: UInt, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        try value.encode(to: _RedisHashEncoder(encodedContent: encodedContent, codingPath: codingPath + [key]))
    }

    mutating func encodeIfPresent(_ value: Bool?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Double?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Float?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Int8?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Int16?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Int32?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: Int64?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: UInt?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: UInt8?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: UInt16?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: UInt32?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent(_ value: UInt64?, forKey key: Key) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath + [key])
    }

    mutating func encodeIfPresent<T: Encodable>(_ value: T?, forKey key: Key) throws {
        try value.encode(to: _RedisHashEncoder(encodedContent: encodedContent, codingPath: [key]))
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        let redisHashKeyedEncodingContainer = _RedisHashKeyedEncodingContainer<NestedKey>(encodedContent: encodedContent,
                                                                                          codingPath: codingPath + [key])
        return KeyedEncodingContainer(redisHashKeyedEncodingContainer)
    }

    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        _RedisHashUnkeyedEncodingContainer()
    }

    mutating func superEncoder() -> Encoder {
        superEncoder(forKey: Key(stringValue: "super")!)
    }

    mutating func superEncoder(forKey key: Key) -> Encoder {
        _RedisHashEncoder(encodedContent: encodedContent, codingPath: codingPath + [key])
    }
}

// MARK: - _RedisHashUnkeyedEncodingContainer -
fileprivate struct _RedisHashUnkeyedEncodingContainer {}

extension _RedisHashUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    var codingPath: [CodingKey] {
        []
    }
    
    var count: Int {
        -1
    }
    
    mutating func encodeNil() throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Bool) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: String) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Double) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Float) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Int) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Int8) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Int16) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Int32) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: Int64) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: UInt) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: UInt8) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: UInt16) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: UInt32) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode(_ value: UInt64) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func encode<T: Encodable>(_ value: T) throws {
        throw RedisHashEncoder.EncodingError.objectContainingArray
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
        KeyedEncodingContainer(_RedisHashKeyedEncodingContainer(encodedContent: .init(), codingPath: []))
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        _RedisHashUnkeyedEncodingContainer()
    }
    
    mutating func superEncoder() -> Encoder {
        _RedisHashEncoder()
    }
}

// MARK: - _RedisHashSingleValueEncodingContainer -
fileprivate struct _RedisHashSingleValueEncodingContainer {
    private let encodedContent: _RedisHashEncoder.EncodedContent
    let codingPath: [CodingKey]
    
    init(encodedContent: _RedisHashEncoder.EncodedContent, codingPath: [CodingKey]) {
        self.encodedContent = encodedContent
        self.codingPath = codingPath
    }
}

extension _RedisHashSingleValueEncodingContainer: SingleValueEncodingContainer {
    mutating func encodeNil() throws {
        encodedContent.insert(value: "null", at: codingPath)
    }

    mutating func encode(_ value: Bool) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: String) throws {
        encodedContent.insert(value: value, at: codingPath)
    }

    mutating func encode(_ value: Double) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: Float) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: Int) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: Int8) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: Int16) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: Int32) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: Int64) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: UInt) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: UInt8) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: UInt16) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: UInt32) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode(_ value: UInt64) throws {
        encodedContent.insert(value: .init(describing: value), at: codingPath)
    }

    mutating func encode<T: Encodable>(_ value: T) throws {
        try value.encode(to: _RedisHashEncoder(encodedContent: encodedContent, codingPath: codingPath))
    }
}
