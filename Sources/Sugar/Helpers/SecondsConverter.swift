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
