import Foundation

public extension Optional where Wrapped == TimeInterval {
    var dateRelativeTo1970: Date? {
        guard let date = self else {
            return nil
        }

        return Date(timeIntervalSince1970: date)
    }
}

public extension TimeInterval {
    var dateRelativeTo1970: Date {
        return Date(timeIntervalSince1970: self)
    }
}
