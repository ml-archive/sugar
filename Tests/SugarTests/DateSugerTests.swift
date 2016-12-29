import XCTest
import Foundation
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
        let timezoneDelta = TimeZone.current.secondsFromGMT()/3600
        let iso8601Str = "2016-12-29T12:35:51+0" + String(timezoneDelta) + "00"
        XCTAssertEqual(try Date.parse(.ISO8601, iso8601Str)?.to(.ISO8601), iso8601Str)
    }
    
    func testParseOrFail() {
        do {
            let notValidDateTimeString = "2016-12-29T12:35:51+0000"
            _ = try Date.parseOrFail(.dateTime, notValidDateTimeString)
            XCTAssertEqual(false, true)
        } catch {
            XCTAssertEqual(true, true)
        }
    }
    
    func testParseFallback() {
        let notValidDateTimeString = "2016-12-29T12:35:51+0000"
        let fallback = Date()
        XCTAssertEqual(try Date.parse(.dateTime, notValidDateTimeString, fallback).to(.dateTime), try fallback.toDateTimeString())
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
            ("testDateTime", testDateTime),
            ("testDate", testDate),
            ("testISO8601", testISO8601),
            ("testParseOrFail", testParseOrFail),
            ("testParseFallback", testParseFallback),
            ("testPast", testPast),
            ("testFuture", testFuture),
            ("testIsBefore", testIsBefore),
            ("testIsAfter", testIsAfter),
            ("testEqual", testEqual),
        ]
    }
}
