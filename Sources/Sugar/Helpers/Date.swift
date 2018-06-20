import Foundation

public extension Date {
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
}
