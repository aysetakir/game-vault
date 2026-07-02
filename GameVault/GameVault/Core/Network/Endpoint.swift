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

 
