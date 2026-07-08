import SwiftUI
import SwiftData

@main
struct GameVaultApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: FavoriteGame.self)
        } catch {
            fatalError("ModelContainer kurulamadı: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let repository = GameRepositoryImpl(
                apiClient: APIClient(apiKey: AppConfig.rawgAccessToken)
            )
            let favoritesViewModel = FavoritesGameViewModel(context: container.mainContext)
            
            GameListView(
                viewModel: GameListViewModel(repository: repository),
                repository: repository, favoritesViewModel: favoritesViewModel,
                
            )
        }
        .modelContainer(container)
    }
}
