import Foundation

extension GameDTO {
    func toEntity() -> Game {
        Game(
            id: id,
            slug: slug,
            name: name,
            released: released,
            backgroundImage: backgroundImage.flatMap(URL.init(string:)),
            rating: rating,
            metacritic: metacritic
        )
    }
}
