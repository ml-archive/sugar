import XCTest
import Foundation
@testable import Sugar

class DateSugarTests: XCTestCase {
    
    func testEndOfWeek() {
        let dateTimeStr = "2017-01-21 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.endOfWeek.toDateTimeString(), "2017-01-22 23:59:59")
    }
    
    func testStartOfWeek() {
        let dateTimeStr = "2017-01-22 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.startOfWeek.toDateTimeString(), "2017-01-16 00:00:00")
    }
    
    func testSubMultipleMonths() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subMonths(10).toDateTimeString(), "2015-03-15 12:23:45")
    }
    
    func testASubMonth() {
        let dateTimeStr = "2016-03-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subMonth().toDateTimeString(), "2016-02-15 12:23:45")
    }
    
    func testAddMultipleMonths() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addMonths(10).toDateTimeString(), "2016-11-15 12:23:45")
    }
    
    func testAddMonth() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addMonth().toDateTimeString(), "2016-02-15 12:23:45")
    }
    
    func testSubWeek() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subWeek().toDateTimeString(), "2016-01-08 12:23:45")
    }
    
    func testSubMultipleWeeks() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subWeeks(4).toDateTimeString(), "2015-12-18 12:23:45")
    }
    
    func testAddWeek() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addWeek().toDateTimeString(), "2016-01-22 12:23:45")
    }
    
    func testAddMultipleWeeks() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addWeeks(4).toDateTimeString(), "2016-02-12 12:23:45")
    }
    
    func testSubDay() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subDay().toDateTimeString(), "2016-01-14 12:23:45")
    }
    
    func testSubMultipleDays() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subDays(10).toDateTimeString(), "2016-01-05 12:23:45")
    }
    
    func testSubMultipleDaysOverMonth() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.subDays(30).toDateTimeString(), "2015-12-16 12:23:45")
    }
    
    func testAddDay() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addDay().toDateTimeString(), "2016-01-16 12:23:45")
    }
    
    func testAddMultipleDays() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addDays(10).toDateTimeString(), "2016-01-25 12:23:45")
    }
    
    func testAddMultipleDaysOverMonth() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.addDays(30).toDateTimeString(), "2016-02-14 12:23:45")
    }
    
    func testStartOfMonth() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.startOfMonth.toDateTimeString(), "2016-01-01 00:00:00")
    }
    
    func testEndOfMonthLarge() {
        let dateTimeStr = "2016-01-15 12:23:45"
        XCTAssertEqual(try Date.parse(.dateTime, dateTimeStr)?.endOfOfMonth.toDateTimeString(), "2016-01-31 23:59:59")
    }
    
    func testEndOfMonthVerySmall() {
        let dateTimeStr = "2016-02-15 12:23:45"
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
    
    func testPastOrNow1() {
        let past = Date().addingTimeInterval(-1)
        XCTAssertTrue(past.isPastOrNow())
    }
    
    /*
    func testPastOrNow2() {
        XCTAssertTrue(Date().isPastOrNow())
    }
     */
    
    func testFuture() {
        let future = Date().addingTimeInterval(1)
        XCTAssertTrue(future.isFuture())
    }
    
    func testFutureOrNow1() {
        let future = Date().addingTimeInterval(1)
        XCTAssertTrue(future.isFutureOrNow())
    }
    
    /*
    func testFutureOrNow2() {
        XCTAssertTrue(Date().isFutureOrNow())
    }
     */
    
    func testIsBeforeOrEqual() {
        let now = Date()
        let past = Date().addingTimeInterval(-1)
        
        XCTAssertTrue(past.isBefore(now))
    }
    
    func testIsBefore() {
        let now = Date()
        let past = Date().addingTimeInterval(-1)
        
        XCTAssertTrue(past.isBefore(now))
    }
    
    func testIsBeforeOrEqual1() {
        let now = Date()
        let past = Date().addingTimeInterval(-1)
        
        XCTAssertTrue(past.isBeforeOrEqual(now))
    }
    
    func testIsBeforeOrEqual2() {
        let now = Date()
        let now2 = Date()
        
        XCTAssertTrue(now2.isBeforeOrEqual(now))
    }
    
    func testIsAfter() {
        let now = Date()
        let past = Date().addingTimeInterval(1)
        
        XCTAssertTrue(now.isAfter(past))
    }
    
    func testIsAfterOrEqual1() {
        let now = Date()
        let past = Date().addingTimeInterval(1)
        
        XCTAssertTrue(now.isAfterOrEqual(past))
    }
    
    func testIsAfterOrEqual2() {
        let now = Date()
        let now2 = Date()
        
        XCTAssertTrue(now.isAfterOrEqual(now2))
    }
    
    func testEqual() {
        let now = Date()
        
        XCTAssertTrue(now.isEqual(now))
    }
    
    /* Does not work
    func testIsNow() {
        XCTAssertTrue(Date().isNow())
    }
     */
    
    static var allTests : [(String, (DateSugarTests) -> () throws -> Void)] {
        return [
            /*
             ("testSubMonth", testSubMonth),
             ("testSubMultipleMonths", testSubMultipleMonths),
             ("testAddMonth", testAddMonth),
             ("testAddMultipleMonths", testAddMultipleMonths),
            */
            
            ("testSubWeek", testSubWeek),
            ("testSubMultipleWeeks", testSubMultipleWeeks),
            ("testAddWeek", testAddWeek),
            ("testAddMultipleWeeks", testAddMultipleWeeks),
            ("testSubDay", testSubDay),
            ("testSubMultipleDays", testSubMultipleDays),
            ("testSubMultipleDaysOverMonth", testSubMultipleDaysOverMonth),
            ("testAddDay", testAddDay),
            ("testAddMultipleDays", testAddMultipleDays),
            ("testAddMultipleDaysOverMonth", testAddMultipleDaysOverMonth),
            ("testStartOfMonth", testStartOfMonth),
            /*
            ("testEndOfMonthVerySmall", testEndOfMonthVerySmall),
            ("testEndOfMonthLarge", testEndOfMonthLarge),
            ("testEndOfDay", testEndOfDay),
            ("testStartOfDay", testStartOfDay),
 */
            ("testDateTime", testDateTime),
            ("testDate", testDate),
            ("testISO8601", testISO8601),
            ("testParseOrFailError", testParseOrFailError),
            ("testParseOrFailSuccess", testParseOrFailSuccess),
            ("testParseFallbackError", testParseFallbackError),
            ("testParseFallbackSuccess", testParseFallbackSuccess),
            ("testPast", testPast),
            ("testPastOrNow1", testPastOrNow1),
            //("testPastOrNow2", testPastOrNow2),
            
            ("testFuture", testFuture),
            ("testFutureOrNow1", testFutureOrNow1),
            //("testFutureOrNow2", testFutureOrNow2),
            
            ("testIsBefore", testIsBefore),
            ("testIsBeforeOrEqual1", testIsBeforeOrEqual1),
            ("testIsBeforeOrEqual2", testIsBeforeOrEqual2),
            ("testIsAfter", testIsAfter),
            ("testIsAfterOrEqual1", testIsAfterOrEqual1),
            ("testIsAfterOrEqual2", testIsAfterOrEqual2),
            //("testIsNow", testIsNow),
            ("testEqual", testEqual),
        ]
    }
}
