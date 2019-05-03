import Foundation

public extension Date {

    static let hourInSec = 3600
    static let minInSec = 60

    static func startOfMonth() -> Date? {
        return Date().startOfMonth()
    }

    static func endOfMonth() -> Date? {
        return Date().endOfMonth()
    }

    func startOfMonth(calendar: Calendar = .current) -> Date? {
        return calendar.date(
            from: calendar.dateComponents([.year, .month],
            from: calendar.startOfDay(for: self))
        )
    }

    func endOfMonth(calendar: Calendar = .current) -> Date? {
        guard let startOfMonth = self.startOfMonth() else { return nil }
        return calendar.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: startOfMonth
        )
    }

    func add(days: Int, calendar: Calendar = .current) -> Date? {
        return calendar.date(
            byAdding: DateComponents(day: days),
            to: self
        )
    }

    func sub(days: Int, calendar: Calendar = .current) -> Date? {
        return calendar.date(
            byAdding: DateComponents(day: -days),
            to: self
        )
    }

    func add(hours: Int, calendar: Calendar = .current) -> Date? {
        return calendar.date(
            byAdding: DateComponents(hour: hours),
            to: self
        )
    }

    func sub(hours: Int, calendar: Calendar = .current) -> Date? {
        return calendar.date(
            byAdding: DateComponents(hour: -hours),
            to: self
        )
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
    func dateBySetting(
        hour: Int,
        minute: Int,
        second: Int,
        calendar: Calendar = .current
    ) -> Date? {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        guard let date = calendar.date(from: dateComponents) else { return nil }
        return date.addingTimeInterval(
            TimeInterval(hour * Date.hourInSec + minute * Date.minInSec + second)
        )
    }
}
