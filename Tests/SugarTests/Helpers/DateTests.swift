import Sugar
import Vapor
import XCTest

final class DateTests: XCTestCase {

    // MARK: func dateBySetting(hour:minute:second:calendar:)

    func testDateBySettingHourMinuteSecond() {

        let calendarComponents: Set<Calendar.Component> = Set([.year, .month, .day, .hour, .minute, .second])

        let today = Date()
        let todayStartOfDay = today.dateBySetting(hour: 0, minute: 0, second: 0, calendar: .current)!
        let todayComps = Calendar.current.dateComponents(calendarComponents, from: today)
        let todayStartOfDayComps = Calendar.current.dateComponents(calendarComponents, from: todayStartOfDay)

        XCTAssertEqual(todayStartOfDayComps.year, todayComps.year, "Year changed!")
        XCTAssertEqual(todayStartOfDayComps.month, todayComps.month, "Month changed!")
        XCTAssertEqual(todayStartOfDayComps.day, todayComps.day, "Day changed!")
        XCTAssertEqual(todayStartOfDayComps.hour, 0, "Hour not correct")
        XCTAssertEqual(todayStartOfDayComps.minute, 0, "Minute not correct")
        XCTAssertEqual(todayStartOfDayComps.second, 0, "Second not correct")
    }
}
