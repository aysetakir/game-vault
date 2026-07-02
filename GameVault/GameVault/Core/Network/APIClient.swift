import Foundation

final class APIClient {
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession) {
        self.apiKey = apiKey
        self.session = session
    }
    
    private func makeURL(for endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.rawg.io"
        components.path = "/api" + endpoint.path
        var items = endpoint.queryItems
        items.append(URLQueryItem(name: "key", value: apiKey))
        components.queryItems = items.isEmpty ? nil : items
        return components.url
    }
}
  
