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
    
    func fetchGameDetail(id: Int) async throws -> GameDetail {
        let endpoint = Endpoint.gameDetail(id: id)
        let dto: GameDetailDTO = try await apiClient.request(endpoint: endpoint)
        return dto.toEntity()
    }
}

