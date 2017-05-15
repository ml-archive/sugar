extension Int {
    var minInSec: Int {
        return 60 * self
    }
    
    var hourInSec: Int {
        return 60 * 60 * self
    }
    
    var dayInSec: Int {
        return 60 * 60 * 24 * self
    }
    
    var weekInSec: Int {
        return 60 * 60 * 24 * 7 * self
    }
}
