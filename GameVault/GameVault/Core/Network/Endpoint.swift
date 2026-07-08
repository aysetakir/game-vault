import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func games(page: Int) -> Endpoint {
        Endpoint(
            path: "/games",
            method: .get,
            queryItems: [URLQueryItem(name: "page", value: String(page))]
        )
    }
}

extension Endpoint {
    static func gameDetail(id: Int) -> Endpoint {
        Endpoint(
            path: "/games/\(id)",
            method: .get,
            queryItems: []
        )
    }
}

extension Endpoint {
    static func searchGames(query: String, page: Int) -> Endpoint {
        Endpoint(
            path: "/games",
            method: .get,
            queryItems: [
                URLQueryItem(
                    name: "search",
                    value: query
                ),
                URLQueryItem(
                    name: "page",
                    value: String(
                        page
                    )
                )
            ]
        )
    }
}
