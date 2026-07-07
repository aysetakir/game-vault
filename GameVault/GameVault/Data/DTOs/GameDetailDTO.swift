struct GameDetailDTO: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let metacritic: Int?
    let descriptionRaw: String?
    let website: String?
}
