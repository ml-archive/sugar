import Foundation

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
    public func next(weekday targetWeekday: Weekday) throws -> Date {
        let components = Calendar(identifier: .gregorian).dateComponents([.weekday], from: self)
        guard let currentWeekday = components.weekday else {
            throw Abort.serverError
        }

        var delta = targetWeekday.rawValue - currentWeekday
        if delta <= 0 {
            delta += 7
        }

        return self.addDays(delta)
    }

    /// Start of week
    /// Take you to monday 00:00:00 current week
    ///
    /// - Returns: Date
    public func startOfWeek(calendar: Calendar = Calendar()) -> Date {
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self.startOfDay())
        components.weekday = .monday.rawValue
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek
    }
    
    
    /// End of week
    /// Take you to sunday 23:59:59 current week
    ///
    /// - Returns: Date
    public func endOfWeek(calendar: Calendar = Calendar()) -> Date {
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self.endOfDay())
        components.weekday = .sunday.rawValue
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek.endOfDay()
    }
    
    /// Sub month
    ///
    /// - Returns: Date
    public func subMonth() -> Date {
        var components = DateComponents()
        components.month = -1
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    /// Sub months
    ///
    /// - Parameter months: Int
    /// - Returns: Date
    public func subMonths(_ months: Int) -> Date {
        var components = DateComponents()
        components.month = -months
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    /// Add month
    ///
    /// - Returns: Date
    public func addMonth() -> Date {
        var components = DateComponents()
        components.month = 1
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    /// Add months
    ///
    /// - Parameter months: Int
    /// - Returns: Date
    public func addMonths(_ months: Int) -> Date {
        var components = DateComponents()
        components.month = months
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    /// Add days
    ///
    /// - Parameter days: Int
    /// - Returns: Date
    public func addDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(days.dayInSec))
    }
    
    /// Add day
    ///
    /// - Returns: Date
    public func addDay() -> Date {
        return self.addingTimeInterval(TimeInterval(1.dayInSec))
    }
    
    /// Sub days
    ///
    /// - Parameter days: Int
    /// - Returns: Date
    public func subDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-days.dayInSec))
    }
    
    /// Sub day
    ///
    /// - Returns: Date
    public func subDay() -> Date {
        return self.addingTimeInterval(TimeInterval(-1.dayInSec))
    }
    
    /// Add weeks
    ///
    /// - Parameter weeks: Int
    /// - Returns: Date
    public func addWeeks(_ weeks: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(weeks.weekInSec))
    }
    
    /// Add week
    ///
    /// - Returns: Date
    public func addWeek() -> Date {
        return self.addingTimeInterval(TimeInterval(1.weekInSec))
    }
    
    /// Sub week
    ///
    /// - Returns: Date
    public func subWeek() -> Date {
        return self.addingTimeInterval(TimeInterval(-1.weekInSec))
    }
    
    /// Sub weeks
    ///
    /// - Parameter weeks: Int
    /// - Returns: Date
    public func subWeeks(_ weeks: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-weeks.weekInSec))
    }
    
    /// Start of day
    ///
    /// - Returns: Date
    public func startOfDay(calendar: Calendar = Calendar()) -> Date {
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    /// End of day
    ///
    /// - Returns: Date
    public func endOfDay(calendar: Calendar = Calendar()) -> Date {
        var components = DateComponents()
        components.day = 1
        let date = calendar.date(byAdding: components, to: self.startOfDay())
        return (date?.addingTimeInterval(-1))!
    }
    
    
    /// Start of month
    ///
    /// - Returns: Date
    public func startOfMonth(calendar: Calendar = Calendar()) -> Date {
        let unitFlags = Set<Calendar.Component>([.year, .month])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    /// End of month
    ///
    /// - Returns: Date
    public func endOfOfMonth() -> Date {
        var components = DateComponents()
        components.month = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfMonth())
        return (date?.addingTimeInterval(-1))!
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
        return try self.to(.dateTime, timezone: timezone)
    }
    
    /// Format date To Date (MySQL)
    /// Format: yyyy-MM-dd
    ///
    /// - Returns: String
    /// - Throws: Error
    public func toDateString(timezone: String? = nil) throws -> String {
        return try self.to(.date, timezone: timezone)
    }
    
    //MARK:  compares
    
    
    /// Is past or now
    ///
    /// - Returns: Bool
    public func isPastOrNow() -> Bool {
        return self.isPast() || self.isNow()
    }
    
    
    /// Is past
    ///
    /// - Returns: Bool
    public func isPast() -> Bool {
        return self.compare(Date()).rawValue < 0
    }
    
    
    /// Is future or now
    ///
    /// - Returns: Bool
    public func isFutureOrNow() -> Bool {
        return self.isFuture() || self.isNow()
    }
    
    
    /// Is Now
    ///
    /// - Returns: Bool
    public func isNow(timezone: String? = nil) -> Bool {
        do {
            try print(self.toDateTimeString(timezone: timezone))
            try print(Date().toDateTimeString(timezone: timezone))
        } catch {
            
        }
        return self.isEqual(Date())
    }
    
    
    /// Is in future
    ///
    /// - Returns: Bool
    public func isFuture() -> Bool {
        return self.compare(Date()).rawValue > 0
    }
    
    /// Is after or equal
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isAfterOrEqual(_ date: Date) -> Bool {
        return self.isAfter(date) || isEqual(date)
    }
    
    /// Is After
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isAfter(_ date: Date) -> Bool {
        return self.compare(date).rawValue > 0
    }
    
    /// Is before or equal
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isBeforeOrEqual(_ date: Date) -> Bool {
        return self.isBefore(date) || self.isEqual(date)
    }
    
    
    /// Is Before
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isBefore(_ date: Date) -> Bool {
        return self.compare(date).rawValue < 0
    }
    
    /// is Euqal
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    public func isEqual(_ date: Date) -> Bool {
        return self.compare(date).rawValue == 0
    }
 
    
    /// Make a copy
    ///
    /// - Returns: Date
    public func copy() -> Date {
        return Date(timeIntervalSince1970: self.timeIntervalSince1970)
    }
}
