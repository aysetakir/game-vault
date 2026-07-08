import Foundation
import SwiftData

@MainActor
@Observable
final class FavoritesGameViewModel {
    private(set) var favorites: [FavoriteGame] = []
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        loadFavorites()
    }
    
    func loadFavorites() {
        let descriptor = FetchDescriptor<FavoriteGame>()
        favorites = (try? context.fetch(descriptor)) ?? []
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains{ $0.id == id}
    }
    
    func toggleFavorite(id: Int, name: String, backgroundImage: String?, rating: Double) {
        if let existing = favorites.first(where: { $0.id == id}) {
            context.delete(existing)
        } else {
            context.insert(FavoriteGame(id: id, name: name, backgroundImage: backgroundImage, rating: rating))
        }
        try? context.save()
        loadFavorites()
        
    }
}
