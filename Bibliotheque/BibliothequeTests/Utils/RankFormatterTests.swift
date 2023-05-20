//
//  RankFormatterTests.swift
//  BibliothequeTests
//
//  Created by Artem Marhaza on 19/05/2023.
//

import XCTest
@testable import Bibliotheque

final class RankFormatterTests: XCTestCase {
    var formatter: RankFormatter!

    override func setUp() {
        super.setUp()
        formatter = RankFormatter()
    }

    func testStringifyPositiveNumber() {
        let result = formatter.stringify(5)
        XCTAssertEqual(result, "+5")
    }

    func testStringifyNegativeNumber() {
        let result = formatter.stringify(-5)
        XCTAssertEqual(result, "-5")
    }
    
    func testStringifyZero() {
        let result = formatter.stringify(0)
        XCTAssertEqual(result, "0")
    }
}
