import Foundation

final class APIClient {
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = makeURL(for: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response): (Data,URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw NetworkError.requestFailed(error)
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
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

