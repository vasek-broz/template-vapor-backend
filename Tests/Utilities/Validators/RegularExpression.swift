//  RegularExpression.swift
//  Created by Václav Brož on 27/11/2022.

@testable import Application
import XCTVapor

final class RegularExpressionValidatorTests: XCTestCase {
    func testPhoneNumberValidation() throws {
        let phoneNumberStringValidator = Validator<String>
            .matchesRegEx("^\\+?\\d{1,4}?[\\s]?\\(?\\d{1,3}?\\)?[\\s]?\\d{1,4}[\\s]?\\d{1,4}[\\s]?\\d{1,9}$")
        
        XCTAssertFalse(phoneNumberStringValidator.validate("+440749263892").isFailure)
        XCTAssertFalse(phoneNumberStringValidator.validate("00420749257839").isFailure)
        XCTAssert(phoneNumberStringValidator.validate("Hello World!").isFailure)
    }
}
