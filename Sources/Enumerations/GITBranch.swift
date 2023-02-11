//  GITBranch.swift
//  Created by Václav Brož on 11/2/2023

enum GITBranch: Equatable {
    // MARK: - Constants -
    private static let DEVELOPMENT_NAME = "development"
    private static let MASTER_NAME = "master"
    private static let FEATURE_PATH_PREFIX = "feature"
    private static let MODIFICATION_PATH_PREFIX = "modification"
    private static let BUGFIX_PATH_PREFIX = "bugfix"
    private static let OTHER_PATH_PREFIX = "other"
    private static let HOTFIX_PATH_PREFIX = "hotfix"
    
    // MARK: - Cases -
    case development
    case master
    case feature(name: String)
    case modification(name: String)
    case bugfix(name: String)
    case other(name: String)
    case hotfix(name: String)
    
    // MARK: - Initializer -
    init(string: String) throws {
        switch string {
        case GITBranch.DEVELOPMENT_NAME:
            self = .development
        case GITBranch.MASTER_NAME:
            self = .master
        default:
            let pathPrefix = string.prefix { $0 != "/" }
            switch pathPrefix {
            case GITBranch.FEATURE_PATH_PREFIX:
                let nameSuffix = string.suffix { $0 != "/" }
                self = .feature(name: .init(describing: nameSuffix))
            case GITBranch.MODIFICATION_PATH_PREFIX:
                let nameSuffix = string.suffix { $0 != "/" }
                self = .modification(name: .init(describing: nameSuffix))
            case GITBranch.BUGFIX_PATH_PREFIX:
                let nameSuffix = string.suffix { $0 != "/" }
                self = .bugfix(name: .init(describing: nameSuffix))
            case GITBranch.OTHER_PATH_PREFIX:
                let nameSuffix = string.suffix { $0 != "/" }
                self = .other(name: .init(describing: nameSuffix))
            case GITBranch.HOTFIX_PATH_PREFIX:
                let nameSuffix = string.suffix { $0 != "/" }
                self = .hotfix(name: .init(describing: nameSuffix))
            default:
                throw InitializationError.stringArgumentDoesNotMatchAnyDefinedCase
            }
        }
    }
    
    // MARK: - Nested Types -
    enum InitializationError: Error {
        case stringArgumentDoesNotMatchAnyDefinedCase
    }
}
