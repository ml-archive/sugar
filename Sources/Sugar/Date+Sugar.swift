import Foundation
import Vapor

extension Date {
    // MARK: Errors
    public enum Error: Swift.Error {
        case couldNotParse
    }

    // MARK: Formats
    public enum Format: String {
        case dateTime = "yyyy-MM-dd HH:mm:ss"
        case date = "yyyy-MM-dd"
        case ISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    }

    // MARK: Weekdays
    public enum Weekday: Int {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }

    // MARK: Manipulators

    /// Next
    /// Returns the next `weekday` starting from the provided date.
    ///
    /// - Returns: Date
    public func next(weekday targetWeekday: Weekday, calendar: Calendar = .current) throws -> Date {
        let components = calendar.dateComponents([.weekday], from: self)
        guard let currentWeekday = components.weekday else {
            throw Abort.serverError
        }

        var delta = targetWeekday.rawValue - currentWeekday
        if delta <= 0 {
            delta += 7
        }

        return addDays(delta)
    }

    /// Start of week
    /// Take you to monday 00:00:00 current week
    ///
    /// - Returns: Date
    public func startOfWeek(calendar: Calendar = .current) -> Date {
        var calendar = calendar
        calendar.firstWeekday = Weekday.monday.rawValue
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        components.weekday = Weekday.monday.rawValue
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek
    }

    /// End of week
    /// Take you to sunday 23:59:59 current week
    ///
    /// - Returns: Date
    public func endOfWeek(calendar: Calendar = .current) -> Date {
        var calendar = calendar
        calendar.firstWeekday = Weekday.monday.rawValue
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        components.weekday = Weekday.sunday.rawValue
        let endOfWeek = calendar.date(from: components)!
        return endOfWeek.endOfDay(calendar: calendar)
    }

    /// Sub month
    ///
    /// - Returns: Date
    public func subMonth(calendar: Calendar = .current) -> Date {
        return subMonths(1, calendar: calendar)
    }

    /// Sub months
    ///
    /// - Parameter months: Int
    /// - Returns: Date
    public func subMonths(_ months: Int, calendar: Calendar = .current) -> Date {
        return addMonths(-months, calendar: calendar)
    }

    /// Add month
    ///
    /// - Returns: Date
    public func addMonth(calendar: Calendar = .current) -> Date {
        return addMonths(1, calendar: calendar)
    }

    /// Add months
    ///
    /// - Parameter months: Int
    /// - Returns: Date
    public func addMonths(_ months: Int, calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .init(month: months), to: self)!
    }

    /// Add days
    ///
    /// - Parameter days: Int
    /// - Returns: Date
    public func addDays(_ days: Int, calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .init(day: days), to: self)!
    }

    /// Add day
    ///
    /// - Returns: Date
    public func addDay(calendar: Calendar = .current) -> Date {
        return addDays(1, calendar: calendar)
    }

    /// Sub days
    ///
    /// - Parameter days: Int
    /// - Returns: Date
    public func subDays(_ days: Int, calendar: Calendar = .current) -> Date {
        return addDays(-days, calendar: calendar)
    }

    /// Sub day
    ///
    /// - Returns: Date
    public func subDay(calendar: Calendar = .current) -> Date {
        return subDays(1, calendar: calendar)
    }

    /// Add weeks
    ///
    /// - Parameter weeks: Int
    /// - Returns: Date
    public func addWeeks(_ weeks: Int, calendar: Calendar = .current) -> Date {
        return addDays(weeks * 7, calendar: calendar)
    }

    /// Add week
    ///
    /// - Returns: Date
    public func addWeek(calendar: Calendar = .current) -> Date {
        return addWeeks(1, calendar: calendar)
    }

    /// Sub week
    ///
    /// - Returns: Date
    public func subWeek(calendar: Calendar = .current) -> Date {
        return subWeeks(1, calendar: calendar)
    }

    /// Sub weeks
    ///
    /// - Parameter weeks: Int
    /// - Returns: Date
    public func subWeeks(_ weeks: Int, calendar: Calendar = .current) -> Date {
        return addWeeks(-weeks, calendar: calendar)
    }

    /// Start of day
    ///
    /// - Returns: Date
    public func startOfDay(calendar: Calendar = .current) -> Date {
        return calendar.startOfDay(for: self)
    }

    /// End of day
    ///
    /// - Returns: Date
    public func endOfDay(calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .init(day: 1, second: -1), to: startOfDay())!
    }

    /// Start of month
    ///
    /// - Returns: Date
    public func startOfMonth(calendar: Calendar = .current) -> Date {
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }

    /// End of month
    ///
    /// - Returns: Date
    public func endOfOfMonth(calendar: Calendar = .current) -> Date {
        return calendar.date(byAdding: .init(month: 1, second: -1), to: startOfMonth())!
    }

    /// Set hour/min/sec of a date
    ///
    /// Replaces `Calendar().date(bySettingHour hour: Int, minute: Int, ...)` which is not
    /// running on Linux yet.
    ///
    /// - Parameters:
    ///   - hour: Int
    ///   - minute: Int
    ///   - second: Int
    /// - Returns: Date?
    public func dateBySetting(hour: Int, minute: Int, second: Int, calendar: Calendar = .current) -> Date? {
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.date(from: components)
    }

    //MARK:  Custom parsers

    /// Parse
    ///
    /// - Parameters:
    ///   - format: String fx: yyyy-MM-dd
    ///   - date: String
    /// - Returns: Date?
    public static func parse(_ format: String, _ date: String, timezone: String? = nil, formatter: DateFormatter = DateFormatter()) -> Date? {
        formatter.dateFormat = format

        if let timezone = timezone {
            formatter.timeZone = TimeZone(identifier: timezone)
        }

        return formatter.date(from: date)
    }

    /// Parse or fail, if you want a parse error if parsing fails
    ///
    /// - Parameters:
    ///   - format: String fx: yyyy-MM-dd
    ///   - date: String
    /// - Returns: Date
    /// - Throws: Parse error
    public static func parseOrFail(_ format: String, _ date: String, timezone: String? = nil) throws -> Date {
        let dateOptional = parse(format, date, timezone: timezone)

        guard let date = dateOptional else {
            throw Error.couldNotParse
        }

        return date
    }

    /// Parse wit fallback
    ///
    /// - Parameter
    ///   - format: String fx: yyyy-MM-dd
    ///   - date: String
    ///   - fallback: Fallback Date
    /// - Returns: Date
    public static func parse(_ format: String, _ date: String, _ fallback: Date, timezone: String? = nil) -> Date {
        let dateOptional = parse(format, date, timezone: timezone)

        guard let date = dateOptional else {
            return fallback
        }

        return date
    }

    //MARK: Enum parsers

    /// Parse from Format
    ///
    /// - Parameters:
    ///   - format: Format
    ///   - date: String
    /// - Returns: Date?
    public static func parse(_ format: Format, _ date: String, timezone: String? = nil) -> Date? {
        return parse(format.rawValue, date, timezone: timezone)
    }

    /// Parse or Fail
    /// Should be used if you want a parse error if parsing failed
    ///
    /// - Parameters:
    ///   - format: Format
    ///   - date: String
    /// - Returns: Date
    public static func parseOrFail(_ format: Format, _ date: String, timezone: String? = nil) throws -> Date {
        return try parseOrFail(format.rawValue, date, timezone: timezone)
    }

    /// Parse from Format with fallback
    ///
    /// - Parameters:
    ///   - format: Format
    ///   - date: String
    ///   - fallback: Date
    /// - Returns: Date
    public static func parse(_ format: Format, _ date: String, _ fallback: Date, timezone: String? = nil) -> Date {
        return parse(format.rawValue, date, fallback, timezone: timezone)
    }

    //MARK: Formatters

    /// To argument format
    ///
    /// - Parameter format: String fx: yyyy-MM-dd
    /// - Returns: String
    /// - Throws: Error
    public func to(_ format: String, timezone: String? = nil, formatter: DateFormatter = DateFormatter()) throws -> String {
        formatter.dateFormat = format

        if let timezone = timezone {
            formatter.timeZone = TimeZone(identifier: timezone)
        }

        return formatter.string(from: self)
    }

    /// To argument format
    ///
    /// - Parameter format: Format
    /// - Returns: String
    /// - Throws: Error
    public func to(_ format: Format, timezone: String? = nil) throws -> String {
        return try to(format.rawValue, timezone: timezone)
    }

    /// Format date To DateTime (MySQL)
    /// Format: yyyy-MM-dd HH:mm:ss
    ///
    /// - Returns: String
    /// - Throws: Error
    public func toDateTimeString(timezone: String? = nil) throws -> String {
        return try to(.dateTime, timezone: timezone)
    }

    /// Format date To Date (MySQL)
    /// Format: yyyy-MM-dd
    ///
    /// - Returns: String
    /// - Throws: Error
    public func toDateString(timezone: String? = nil) throws -> String {
        return try to(.date, timezone: timezone)
    }

    //MARK: Comparisons

    /// Is past or now
    ///
    /// - Returns: Bool
    public func isPastOrNow() -> Bool {
        return isPast() || isNow()
    }

    /// Is past
    ///
    /// - Returns: Bool
    public func isPast() -> Bool {
        return compare(Date()).rawValue < 0
    }

    /// Is future or now
    ///
    /// - Returns: Bool
    public func isFutureOrNow() -> Bool {
        return isFuture() || isNow()
    }

    /// Is Now
    ///
    /// - Returns: Bool
    public func isNow() -> Bool {
        return isEqual(Date())
    }

    /// Is Now
    ///
    /// - Returns: Bool
    @available(*, deprecated)
    public func isNow(timezone: String?) -> Bool {
        return isNow()
    }

    /// Is in future
    ///
    /// - Returns: Bool
    public func isFuture() -> Bool {
        return compare(Date()).rawValue > 0
    }

    /// Is after or equal
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isAfterOrEqual(_ date: Date) -> Bool {
        return isAfter(date) || isEqual(date)
    }

    /// Is After
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isAfter(_ date: Date) -> Bool {
        return compare(date).rawValue > 0
    }

    /// Is before or equal
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isBeforeOrEqual(_ date: Date) -> Bool {
        return isBefore(date) || isEqual(date)
    }

    /// Is Before
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isBefore(_ date: Date) -> Bool {
        return compare(date).rawValue < 0
    }

    /// is Euqal
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isEqual(_ date: Date) -> Bool {
        return compare(date).rawValue == 0
    }

    /// Make a copy
    ///
    /// - Returns: Date
    public func copy() -> Date {
        return Date(timeIntervalSince1970: timeIntervalSince1970)
    }
}
