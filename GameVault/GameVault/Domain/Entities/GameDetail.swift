import Foundation

struct GameDetail: Identifiable, Equatable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: URL?
    let rating: Double
    let metacritic: Int?
    let description: String?
    let website: URL?
}
