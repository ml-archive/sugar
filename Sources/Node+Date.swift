import Node
import Foundation

extension Date: NodeConvertible {
    public func makeNode(context: Context = EmptyNode) throws -> Node {
        return .string(dateFormatterMySQL.string(from: self))
    }
    
    public init(node: Node, in context: Context) throws {
        switch node {
        case .number(let number):
            self = Date(timeIntervalSince1970: number.double)
            
        case .string(let dateString):
            if let dateMySQL = dateFormatterMySQL.date(from: dateString) {
                self = dateMySQL
            } else if let dateISO8601 = dateFormatterISO8601.date(from: dateString) {
                self = dateISO8601
            } else {
                throw NodeError.unableToConvert(
                    node: node,
                    expected: "MySQL DATETIME or ISO8601 formatted date."
                )
            }
            
        default:
            throw NodeError.unableToConvert(
                node: node,
                expected: "\(String.self), \(Int.self) or \(Double.self))"
            )
        }
    }
}

// DateFormatter init is slow, need to reuse. Reusing two DateFormatters is
// significantly faster than toggling the formatter's `dateFormat` property.
// On Linux, toggling is actually slower than initializing DateFormatter.
private var _dfMySQL: DateFormatter?
private var dateFormatterMySQL: DateFormatter {
    if let df = _dfMySQL {
        return df
    }
    
    let df = DateFormatter()
    df.timeZone = TimeZone(abbreviation: "UTC")
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    _dfMySQL = df
    return df
}

private var _dfISO8601: DateFormatter?
private var dateFormatterISO8601: DateFormatter {
    if let df = _dfISO8601 {
        return df
    }
    
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    _dfISO8601 = df
    return df
}
