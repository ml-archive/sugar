import Random
import Crypto

extension String {
    
    
    /// Random alpha numeric string
    ///
    /// Note this is not
    ///
    /// - Parameter length: length int
    /// - Returns: string
    public static func randomAlphaNumericString(_ length: Int = 64) -> String {
        let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = letters.characters.count
        
        var randomString = ""
        for _ in 0 ..< length {
            let rand = Int.random(min: 0, max: Int(len - 1))
            
            let char = letters.substring(from: rand, length: 1)
            
            randomString += char
        }
        
        return randomString
    }
    
    /// Random string
    ///
    /// Note this string can use all chars, cannot be used for urls params fx
    ///
    /// - Parameter length: length Int
    /// - Returns: String
    /// - Throws: Error
    public static func random(_ length: Int = 64) throws -> String {
        return try Random.bytes(count: length).makeString()
    }
}
