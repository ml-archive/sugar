import Foundation

public extension URL {
    public func addQueryItems(_ item: [URLQueryItem]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }

        let currentItems = components.queryItems ?? []
        components.queryItems = currentItems + item
        return components.url
    }

    public func addQueryItems(from url: URL) -> URL {
        guard
            let items = URLComponents(url: URL, resolvingAgainstBaseURL: false)?.queryItems
        else {
            return self
        }

        return addQueryItems(items)
    }
}
