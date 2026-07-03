import Foundation

struct Game: Identifiable, Equatable {
    let id: Int
    let slug: String
    let name: String
    let released: String?
    let backgroundImage: URL?
    let rating: Double
    let metacritic: Int?
}
