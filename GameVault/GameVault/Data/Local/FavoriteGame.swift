import Foundation
import SwiftData

@Model
final class FavoriteGame {
    @Attribute(.unique) var id: Int
    var name: String
    var backgroundImage: String?
    var rating: Double
    
    init(id: Int, name: String, backgroundImage: String? = nil, rating: Double) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}
