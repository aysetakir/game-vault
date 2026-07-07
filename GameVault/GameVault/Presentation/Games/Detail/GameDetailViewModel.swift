import Foundation

@MainActor
@Observable
final class GameDetailViewModel {
    private(set) var detail: GameDetail?
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private let repository: GameRepository
    private let gameId: Int
    
    init(repository: GameRepository, gameId: Int) {
        self.repository = repository
        self.gameId = gameId
    }
    
    func loadDetail() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
        do {
             detail = try await repository.fetchGameDetail(id: gameId)
        } catch {
            errorMessage = "Oyunun detayına gidilemedi"
        }
    }
}

