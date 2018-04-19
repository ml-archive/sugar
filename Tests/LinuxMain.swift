import XCTest

import SugarTests

var tests = [XCTestCaseEntry]()
tests += SugarTests.allTests()
XCTMain(tests)