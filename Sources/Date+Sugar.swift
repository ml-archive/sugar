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
    
    // MARK: Manipulators
    
    // TODO
    
    public var startOfWeek : Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self.startOfDay)
        components.weekday = 2 // Monday
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek
    }
    
    public var endOfWeek : Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        components.weekday = 1 // Monday
        let startOfWeek = calendar.date(from: components)!
        return startOfWeek.endOfDay
    }
    
    public func subMonth() -> Date {
        var components = DateComponents()
        components.month = -1
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    public func subMonths(_ months: Int) -> Date {
        var components = DateComponents()
        components.month = -months
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    public func addMonth() -> Date {
        var components = DateComponents()
        components.month = 1
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    public func addMonths(_ months: Int) -> Date {
        var components = DateComponents()
        components.month = months
        let date = Calendar.current.date(byAdding: components, to: self)
        return date!
    }
    
    public func addDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(days.dayInSec))
    }
    
    public func addDay() -> Date {
        return self.addingTimeInterval(TimeInterval(1.dayInSec))
    }
    
    public func subDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-days.dayInSec))
    }
    
    public func subDay() -> Date {
        return self.addingTimeInterval(TimeInterval(-1.dayInSec))
    }
    
    public func addWeeks(_ weeks: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(weeks.weekInSec))
    }
    
    public func addWeek() -> Date {
        return self.addingTimeInterval(TimeInterval(1.weekInSec))
    }
    
    public func subWeek() -> Date {
        return self.addingTimeInterval(TimeInterval(-1.weekInSec))
    }
    
    public func subWeeks(_ weeks: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-weeks.weekInSec))
    }
    
    public var startOfDay : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    public var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }
    
    public var startOfMonth : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    public var endOfOfMonth : Date {
        var components = DateComponents()
        components.month = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfMonth)
        return (date?.addingTimeInterval(-1))!
    }
    
    //MARK:  Custom parsers
    
    
    /// Parse
    ///
    /// - Parameters:
    ///   - format: String fx: yyyy-MM-dd
    ///   - date: String
    /// - Returns: Date?
    public static func parse(_ format: String, _ date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date)
    }
    
    
    /// Parse or fail, if you want a parse error if parsing fails
    ///
    /// - Parameters:
    ///   - format: String fx: yyyy-MM-dd
    ///   - date: String
    /// - Returns: Date
    /// - Throws: Parse error
    public static func parseOrFail(_ format: String, _ date: String) throws -> Date {
        let dateOptional = parse(format, date)
        
        
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
    public static func parse(_ format: String, _ date: String, _ fallback: Date) -> Date {
        let dateOptional = parse(format, date)
        
        
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
    public static func parse(_ format: Format, _ date: String) -> Date? {
        return parse(format.rawValue, date)
    }
    
    
    /// Parse or Fail
    /// Should be used if you want a parse error if parsing failed
    ///
    /// - Parameters:
    ///   - format: Format
    ///   - date: String
    /// - Returns: Date
    public static func parseOrFail(_ format: Format, _ date: String) throws -> Date {
        return try parseOrFail(format.rawValue, date)
    }
    
    
    /// Parse from Format with fallback
    ///
    /// - Parameters:
    ///   - format: Format
    ///   - date: String
    ///   - fallback: Date
    /// - Returns: Date
    public static func parse(_ format: Format, _ date: String, _ fallback: Date) -> Date {
        return parse(format.rawValue, date, fallback)
    }
    

    //MARK: Formatters
    
    /// To argument format
    ///
    /// - Parameter format: String fx: yyyy-MM-dd
    /// - Returns: String
    /// - Throws: Error
    public func to(_ format: String) throws -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    
    /// To argument format
    ///
    /// - Parameter format: Format
    /// - Returns: String
    /// - Throws: Error
    public func to(_ format: Format) throws -> String {
        return try to(format.rawValue)
    }
    
    
    /// Format date To DateTime (MySQL)
    /// Format: yyyy-MM-dd HH:mm:ss
    ///
    /// - Returns: String
    /// - Throws: Error
    public func toDateTimeString() throws -> String {
        return try self.to(.dateTime)
    }
    
    /// Format date To Date (MySQL)
    /// Format: yyyy-MM-dd
    ///
    /// - Returns: String
    /// - Throws: Error
    public func toDateString() throws -> String {
        return try self.to(.date)
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
    public func isNow() -> Bool {
        do {
            try print(self.toDateTimeString())
            try print(Date().toDateTimeString())
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
        return date.compare(self).rawValue > 0
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
    /// - Returns: <#return value description#>
    public func copy() -> Date {
        return Date(timeIntervalSince1970: self.timeIntervalSince1970)
    }
}
