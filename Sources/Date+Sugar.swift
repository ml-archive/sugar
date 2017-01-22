import Foundation

extension Date {
    func addDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(days.dayInSec))
    }
    
    func addDay() -> Date {
        return self.addingTimeInterval(TimeInterval(1.dayInSec))
    }
    
    func subDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-days.dayInSec))
    }
    
    func subDay() -> Date {
        return self.addingTimeInterval(TimeInterval(-1.dayInSec))
    }
    
    func addWeeks(_ weeks: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(weeks.weekInSec))
    }
    
    func addWeek() -> Date {
        return self.addingTimeInterval(TimeInterval(1.weekInSec))
    }
    
    func subWeeks(_ weeks: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-weeks.weekInSec))
    }
    
    func subWeek() -> Date {
        return self.addingTimeInterval(TimeInterval(-1.weekInSec))
    }
    
    var startOfDay : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }
    
    var startOfMonth : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    var endOfOfMonth : Date {
        var components = DateComponents()
        components.month = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfMonth)
        return (date?.addingTimeInterval(-1))!
    }
    
    public enum Error: Swift.Error {
        case couldNotParse
    }
    
    public enum Format: String {
        case dateTime = "yyyy-MM-dd HH:mm:ss"
        case date = "yyyy-MM-dd"
        case ISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    //MARK:  Custom parsers
    public static func parse(_ format: String, _ date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date)
    }
    
    public static func parseOrFail(_ format: String, _ date: String) throws -> Date {
        let dateOptional = parse(format, date)
        
        
        guard let date = dateOptional else {
            throw Error.couldNotParse
        }
        
        return date
    }
    
    public static func parse(_ format: String, _ date: String, _ fallback: Date) -> Date {
        let dateOptional = parse(format, date)
        
        
        guard let date = dateOptional else {
            return fallback
        }
        
        return date
    }
    
    //MARK: Enum parsers
    public static func parse(_ format: Format, _ date: String) -> Date? {
        return parse(format.rawValue, date)
    }
    
    public static func parseOrFail(_ format: Format, _ date: String) throws -> Date {
        return try parseOrFail(format.rawValue, date)
    }
    
    public static func parse(_ format: Format, _ date: String, _ fallback: Date) -> Date {
        return parse(format.rawValue, date, fallback)
    }
    

    //MARK: Formatters
    public func to(_ format: String) throws -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    public func to(_ format: Format) throws -> String {
        return try to(format.rawValue)
    }
    
    public func toDateTimeString() throws -> String {
        return try self.to(.dateTime)
    }
    
    //MARK:  compares
    public func isPast() -> Bool {
        return self.compare(Date()).rawValue < 0
    }
    
    public func isFuture() -> Bool {
        return self.compare(Date()).rawValue > 0
    }
    
    public func isAfter(_ date: Date) -> Bool {
        return self.compare(date).rawValue > 0
    }
    
    public func isBefore(_ date: Date) -> Bool {
        return self.compare(date).rawValue < 0
    }
    
    public func isEqual(_ date: Date) -> Bool {
        return self.compare(date).rawValue == 0
    }
 
}
