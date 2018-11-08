import XCTest

import SugarTests

var tests = [XCTestCaseEntry]()
tests += SugarTests.__allTests()

XCTMain(tests)
