import XCTest
import Foundation
@testable import Sugar

class DateSugarTests: XCTestCase {
    func testStartOfMonth() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.startOfMonth.toDateTimeString(), "2016-01-01 00:00:00")
    }
    
    func testEndOfMonthLarge() throws {
        let dateTimeStr = "2016-01-15 12:23:45"
        try print(Date.parse(.dateTime, dateTimeStr)?.endOfOfMonth.toDateTimeString())
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.endOfOfMonth.toDateTimeString(), "2016-01-31 23:59:59")
    }
    
    func testEndOfMonthVerySmall() throws {
        let dateTimeStr = "2016-02-15 12:23:45"
        try print(Date.parse(.dateTime, dateTimeStr)?.endOfOfMonth.toDateTimeString())
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.endOfOfMonth.toDateTimeString(), "2016-02-29 23:59:59")
    }
    
    func testEndOfDay() {
        let dateTimeStr = "2016-01-02 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.endOfDay.toDateTimeString(), "2016-01-02 23:59:59")
    }
    
    func testStartOfDay() {
        let dateTimeStr = "2016-01-02 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.startOfDay.toDateTimeString(), "2016-01-02 00:00:00")
    }
    
    func testDateTime() {
        let dateTimeStr = "2016-01-02 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.toDateTimeString(), dateTimeStr)
    }
    
    func testDate() {
        let dateStr = "2016-01-02"
        XCTAssertEqual(try Date.parse(.date, dateStr)?.to(.date), dateStr)
    }
    
    func testISO8601() {
        let timezoneDelta = TimeZone.current.secondsFromGMT()/3600
        let iso8601Str = "2016-12-29T12:35:51+0" + String(timezoneDelta) + "00"
        XCTAssertEqual(try Date.parse(.ISO8601, iso8601Str)?.to(.ISO8601), iso8601Str)
    }
    
    func testParseOrFailError() {
        do {
            let notValidDateTimeString = "2016-12-29T12:35:51+0000"
            _ = try Date.parseOrFail(.dateTime, notValidDateTimeString)
            XCTAssertEqual(false, true)
        } catch {
            XCTAssertEqual(true, true)
        }
    }
    
    func testParseOrFailSuccess() {
        do {
            let validDateTimeString = "2016-12-29 12:35:51"
            _ = try Date.parseOrFail(.dateTime, validDateTimeString)
            XCTAssertEqual(true, true)
        } catch {
            XCTAssertEqual(false, true)
        }
    }
    
    func testParseFallbackError() {
        let notValidDateTimeString = "2016-12-29T12:35:51+0000"
        let fallback = Date()
        XCTAssertEqual(try Date.parse(.dateTime, notValidDateTimeString, fallback).to(.dateTime), try fallback.toDateTimeString())
    }
    
    func testParseFallbackSuccess() {
        let validDateTimeString = "2016-12-29 12:35:51"
        let fallback = Date()
        XCTAssertEqual(try Date.parse(.dateTime, validDateTimeString, fallback).to(.dateTime), validDateTimeString)
    }
    
    func testPast() {
        let past = Date().addingTimeInterval(-1)
        XCTAssertTrue(past.isPast())
    }
    
    func testFuture() {
        let future = Date().addingTimeInterval(1)
        XCTAssertTrue(future.isFuture())
    }
    
    func testIsBefore() {
        let now = Date()
        let future = Date().addingTimeInterval(-1)
        
        XCTAssertTrue(now.isAfter(future))
    }
    
    func testIsAfter() {
        let now = Date()
        let past = Date().addingTimeInterval(1)
        
        XCTAssertTrue(now.isBefore(past))
    }
    
    func testEqual() {
        let now = Date()
        
        XCTAssertTrue(now.isEqual(now))
    }
    
    static var allTests : [(String, (DateSugarTests) -> () throws -> Void)] {
        return [
            
            ("testStartOfMonth", testStartOfMonth),
            ("testEndOfMonthVerySmall", testEndOfMonthVerySmall),
            ("testEndOfMonthLarge", testEndOfMonthLarge),
            ("testEndOfDay", testEndOfDay),
            ("testStartOfDay", testStartOfDay),
            ("testDateTime", testDateTime),
            ("testDate", testDate),
            ("testISO8601", testISO8601),
            ("testParseOrFailError", testParseOrFailError),
            ("testParseOrFailSuccess", testParseOrFailSuccess),
            ("testParseFallbackError", testParseFallbackError),
            ("testParseFallbackSuccess", testParseFallbackSuccess),
            ("testPast", testPast),
            ("testFuture", testFuture),
            ("testIsBefore", testIsBefore),
            ("testIsAfter", testIsAfter),
            ("testEqual", testEqual),
        ]
    }
}
