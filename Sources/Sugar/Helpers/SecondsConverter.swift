// These helpers are not ideal for calculating specific moments in time (past/future).
// See https://nshipster.com/timeinterval-date-dateinterval/ for more information.
// Instead these helpers should be used for e.g. setting a expiration time of something.
public extension Numeric {
    public var minsInSecs: Self {
        return self * 60
    }

    public var hoursInSecs: Self {
        return self.minsInSecs * 60
    }

    public var daysInSecs: Self {
        return self.hoursInSecs * 24
    }

    public var weeksInSecs: Self {
        return self.daysInSecs * 7
    }
}
