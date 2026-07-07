import Foundation

extension GameDetailDTO {
    func toEntity() -> GameDetail {
        GameDetail(
            id: id,
            name: name,
            released: released,
            backgroundImage: backgroundImage.flatMap(URL.init(string:)),
            rating: rating,
            metacritic: metacritic,
            description: descriptionRaw,
            website: website.flatMap(URL.init(string:))
        )
    }
}
