//  RegularExpression.swift
//  Created by Václav Brož on 27/12/2022

import Vapor

// TODO: Modify this validator so it is not possible to use it directly (it should serve just for creation of validatiors with individual regular expressions)

extension Validator where T == String {
    static func matchesRegEx(_ regularExpression: String) -> Validator<T> {
        .init { string in
            let rangeOfRegExInString = string.range(of: regularExpression, options: [.regularExpression])
            let stringMatchesRegularExpression = rangeOfRegExInString?.lowerBound == string.startIndex && rangeOfRegExInString?.upperBound == string.endIndex
            return ValidatorResults.RegularExpression(matches: stringMatchesRegularExpression)
        }
    }
}

extension ValidatorResults {
    struct RegularExpression {
        let matches: Bool
    }
}

extension ValidatorResults.RegularExpression: ValidatorResult {
    var isFailure: Bool {
        !matches
    }
    
    var successDescription: String? {
        nil
    }
    
    var failureDescription: String? {
        nil
    }
}
