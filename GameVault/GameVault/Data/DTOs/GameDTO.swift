import Foundation

struct GamePageDTO: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameDTO]
}

struct GameDTO: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let metacritic: Int?
}
