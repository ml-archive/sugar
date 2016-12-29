import XCTest
@testable import Sugar

class DateSugarTests: XCTestCase {
    func testDateTime() {
        let dateTimeStr = "2016-01-02 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.toDateTimeString(), dateTimeStr)
    }
    
    func testDate() {
        let dateStr = "2016-01-02"
        XCTAssertEqual(try Date.parse(.date, dateStr)?.to(.date), dateStr)
    }
    
    func testISO8601() {
        let iso8601Str = "2016-12-29T12:35:51+0100"
        XCTAssertEqual(try Date.parse(.ISO8601, iso8601Str)?.to(.ISO8601), iso8601Str)
    }
    
    func testParseOrFail() {
        do {
            let notValidDateTimeString = "2016-12-29T12:35:51+0100"
            _ = try Date.parseOrFail(.dateTime, notValidDateTimeString)
            XCTAssertEqual(false, true)
        } catch {
            XCTAssertEqual(true, true)
        }
        
    }
    
    static var allTests : [(String, (DateSugarTests) -> () throws -> Void)] {
        return [
            ("testDateTime", testDateTime),
            ("testDate", testDate),
            ("testISO8601", testISO8601),
        ]
    }
}
