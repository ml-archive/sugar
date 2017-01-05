import XCTest
@testable import SugarTests

XCTMain([
     testCase(DateSugarTests.allTests),
     testCase(CreatorMySQLTests.allTests),
     testCase(DatabaseMySQLTests.allTests),
])
