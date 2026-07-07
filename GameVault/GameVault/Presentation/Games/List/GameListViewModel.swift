import Foundation

@MainActor
@Observable
final class GameListViewModel {
    private(set) var games: [Game] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private let repository: GameRepository
    private var currentPage = 1
    private var hasNextPage = true

    init(repository: GameRepository) {
        self.repository = repository
    }
     
    
    func loadGames() async {
        guard !isLoading, hasNextPage else { return }
        isLoading = true
        errorMessage = nil
        do {
            let page = try await repository.fetchGames(page: currentPage)
            self.games.append(contentsOf: page.games)
            hasNextPage = page.hasNextPage
            currentPage += 1
        } catch {
            errorMessage = "Oyunlar yüklenemedi"
        }
        isLoading = false
    }
    
    
}
