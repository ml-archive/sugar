import Core
import Crypto
import Foundation

extension String {
    /// Generates a String of random characters (path safe)
    public static func random(length: Int) throws -> String {
        return try Random.bytes(count: length).base64Encoded.string().replacingOccurrences(
            of: "/", with: "_"
        )
    }
}

extension String {
    /// Returns the first match for the provided regex.
    ///
    /// - Parameter regex: Regex to check for.
    /// - Returns: Returns the match (if any).
    internal func firstMatch(regex: String) -> String? {
        guard let range = self.range(of: regex, options: .regularExpression) else {
            return nil
        }
        return self.substring(with: range)
    }
    
    /// Returns all matches for the provided regex.
    ///
    /// - Parameter regex: Regex to check for.
    /// - Returns: A list of matches (if any).
    internal func matches(regex: String) -> [String] {
        #if os(Linux)
            do {
                let regex = try RegularExpression(pattern: regex, options: [])
                let nsString = NSString(string: self)
                let results = regex.matches(
                    in: self,
                    options: [],
                    range: NSRange(location: 0, length: nsString.length)
                )
                return results.map { nsString.substring(with: $0.range) }
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        #else
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let nsString = self as NSString
                let results = regex.matches(
                    in: self,
                    range: NSRange(location: 0, length: nsString.length)
                )
                return results.map { nsString.substring(with: $0.range) }
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        #endif
    }
    
    internal func replace(_ regex: String, with replacement: String) -> String {
        var result = self
        
        let matches = self.matches(regex: regex)
        matches.forEach {
            result = result.replacingOccurrences(of: $0, with: replacement)
        }
        
        return result
    }
    
    /// Tells if the string has any match for the given regex.
    ///
    /// - Parameter regex: Regex to check for.
    /// - Returns: A bool telling if the regex had any matches.
    internal func isMatching(regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    /// The string being url encoded.
    internal func urlEncoded() throws -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet())!
    }
}


// MARK: - Convenience for optional strings.
extension Optional where Wrapped: ExpressibleByStringLiteral {
    /// Falls back to an empty string if no value is found.
    internal var safeUnwrap: String {
        guard let string = self as? String else {
            return ""
        }
        return string
    }
}

extension String {
    /// Checks on a list of prefixes. Will return true if one matches.
    ///
    /// - Parameter prefixes: List of prefixes.
    /// - Returns: If one prefix matches.
    public func hasPrefix(_ strings: [String]) -> Bool {
        for string in strings {
            if self.hasPrefix(string) {
                return true
            }
        }
        
        return false
    }
}
