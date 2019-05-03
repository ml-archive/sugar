// These helpers are not ideal for calculating specific moments in time (past/future).
// See https://nshipster.com/timeinterval-date-dateinterval/ for more information.
// Instead these helpers should be used for e.g. setting a expiration time of something.
public extension Numeric {
    var minsInSecs: Self {
        return self * 60
    }

    var hoursInSecs: Self {
        return self.minsInSecs * 60
    }

    var daysInSecs: Self {
        return self.hoursInSecs * 24
    }

    var weeksInSecs: Self {
        return self.daysInSecs * 7
    }
}
