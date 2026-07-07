import SwiftUI

@main
struct GameVaultApp: App {
    var body: some Scene {
        WindowGroup {
            GameListView(
                viewModel: GameListViewModel(
                    repository: GameRepositoryImpl(
                        apiClient: APIClient(
                            apiKey: AppConfig.rawgAccessToken
                        )
                    )
                )
            )
        }
    }
}
