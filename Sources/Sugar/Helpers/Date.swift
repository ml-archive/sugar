import Foundation

public extension Date {

    static let hourInSec = 3600
    static let minInSec = 60

    public static func startOfMonth() -> Date? {
        return Date().startOfMonth()
    }

    public static func endOfMonth() -> Date? {
        return Date().endOfMonth()
    }

    public func startOfMonth() -> Date? {
        return Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month],
            from: Calendar.current.startOfDay(for: self))
        )
    }

    public func endOfMonth() -> Date? {
        guard let startOfMonth = self.startOfMonth() else { return nil }
        return Calendar.current.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: startOfMonth
        )
    }

    public func add(days: Int) -> Date? {
        return Calendar.current.date(
            byAdding: DateComponents(day: days),
            to: self
        )
    }

    public func sub(days: Int) -> Date? {
        return Calendar.current.date(
            byAdding: DateComponents(day: -days),
            to: self
        )
    }

    public func add(hours: Int) -> Date? {
        return Calendar.current.date(
            byAdding: DateComponents(hour: hours),
            to: self
        )
    }

    public func sub(hours: Int) -> Date? {
        return Calendar.current.date(
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
    public func dateBySetting(hour: Int, minute: Int, second: Int) -> Date? {

        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        return date.addingTimeInterval(
            TimeInterval(hour * Date.hourInSec + minute * Date.minInSec + second)
        )
    }
}
