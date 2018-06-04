import Crypto

public extension String {
    public static func randomAlphaNumericString(_ length: Int = 64) -> String {
        func makeRandom(min: Int, max: Int) -> Int {
            let top = max - min + 1
            #if os(Linux)
                // will always be initialized
                guard randomInitialized else { fatalError() }
                return Int(COperatingSystem.random() % top) + min
            #else
                return Int(arc4random_uniform(UInt32(top))) + min
            #endif
        }

        let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = letters.count

        var randomString = ""
        for _ in 0 ..< length {
            let rand = makeRandom(min: 0, max: Int(len - 1))
            let char = letters[letters.index(letters.startIndex, offsetBy: rand)]
            randomString += String(char)
        }

        return randomString
    }
}

#if os(Linux)
    /// Generates a random number between (and inclusive of)
    /// the given minimum and maximum.
    private let randomInitialized: Bool = {
        /// This stylized initializer is used to work around dispatch_once
        /// not existing and still guarantee thread safety
        let current = Date().timeIntervalSinceReferenceDate
        let salt = current.truncatingRemainder(dividingBy: 1) * 100000000
        COperatingSystem.srand(UInt32(current + salt))
        return true
    }()
#endif
