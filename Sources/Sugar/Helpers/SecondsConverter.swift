import Foundation

public extension Int {
    public var minsInSecs: Int {
        return self * 60
    }

    public var hoursInSecs: Int {
        return self.minsInSecs * 60
    }

    public var daysInSecs: Int {
        return self.hoursInSecs * 24
    }

    public var weeksInSecs: Int {
        return self.daysInSecs * 7
    }
}

public extension TimeInterval {
    public var minsInSecs: TimeInterval {
        return self * 60
    }

    public var hoursInSecs: TimeInterval {
        return self.minsInSecs * 60
    }

    public var daysInSecs: TimeInterval {
        return self.hoursInSecs * 24
    }

    public var weeksInSecs: TimeInterval {
        return self.daysInSecs * 7
    }
}
