final class GameRepositoryImpl: GameRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchGames(page: Int) async throws -> GamePage {
        let endpoint = Endpoint.games(page: page)
        let dto: GamePageDTO = try await apiClient.request(endpoint: endpoint)
        let gamePage = dto.toEntity()
        return gamePage
    } 
}
