import SwiftUI

@main
struct GameVaultApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = GameRepositoryImpl(
                apiClient: APIClient(apiKey: AppConfig.rawgAccessToken)
            )
            GameListView(
                viewModel: GameListViewModel(repository: repository),
                repository: repository
            )
        }
    }
}
