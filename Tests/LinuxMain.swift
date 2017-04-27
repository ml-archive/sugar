import XCTest

@testable import SugarTests

XCTMain([
    testCase(DatabaseMySQLTests.allTests),
    testCase(DateSugarTests.allTests),
    testCase(StringSugarTests.allTests)
])
