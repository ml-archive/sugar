import Foundation

public extension URL {
    func addQueryItems(_ item: [URLQueryItem]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return self
        }

        let currentItems = components.queryItems ?? []
        components.queryItems = currentItems + item
        return components.url ?? self
    }

    func addQueryItems(from url: URL) -> URL {
        guard
            let items = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        else {
            return self
        }

        return addQueryItems(items)
    }
}
