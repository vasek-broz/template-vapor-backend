//  GITBranch.swift
//  Created by Václav Brož on 11/2/2023

@testable import Application
import XCTVapor

final class GITBranchXCTestCase: XCTestCase {
    private static let DEVELOPMENT_BRANCH_NAME = "development"
    private static let MASTER_BRANCH_NAME = "master"
    private static let FEATURE_BRANCH_PATH_PREFIX = "feature"
    private static let MODIFICATION_BRANCH_PATH_PREFIX = "modification"
    private static let BUGFIX_BRANCH_PATH_PREFIX = "bugfix"
    private static let OTHER_BRANCH_PATH_PREFIX = "other"
    private static let HOTFIX_BRANCH_PATH_PREFIX = "hotfix"
    private static let UNDEFINED_BRANCH_PATH_PREFIX = "undefined"
    private static let TEST_BRANCH_NAME_SUFFIX = "hotfix"
    
    func testGitBranchInitialiazation() {
        XCTAssertEqual(try GITBranch(string: GITBranchXCTestCase.DEVELOPMENT_BRANCH_NAME), .development)
        XCTAssertEqual(try GITBranch(string: GITBranchXCTestCase.MASTER_BRANCH_NAME), .master)
        XCTAssertEqual(try GITBranch(string: "\(GITBranchXCTestCase.FEATURE_BRANCH_PATH_PREFIX)/\(GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX)"),
                       .feature(name: GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX))
        XCTAssertEqual(try GITBranch(string: "\(GITBranchXCTestCase.MODIFICATION_BRANCH_PATH_PREFIX)/\(GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX)"),
                       .modification(name: GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX))
        XCTAssertEqual(try GITBranch(string: "\(GITBranchXCTestCase.BUGFIX_BRANCH_PATH_PREFIX)/\(GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX)"),
                       .bugfix(name: GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX))
        XCTAssertEqual(try GITBranch(string: "\(GITBranchXCTestCase.OTHER_BRANCH_PATH_PREFIX)/\(GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX)"),
                       .other(name: GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX))
        XCTAssertEqual(try GITBranch(string: "\(GITBranchXCTestCase.HOTFIX_BRANCH_PATH_PREFIX)/\(GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX)"),
                       .hotfix(name: GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX))
        XCTAssertThrowsError(try GITBranch(string: "\(GITBranchXCTestCase.UNDEFINED_BRANCH_PATH_PREFIX)/\(GITBranchXCTestCase.TEST_BRANCH_NAME_SUFFIX)"))
    }
}
