protocol GameRepository {
    func fetchGames(page: Int) async throws -> GamePage
    func fetchGameDetail(id: Int) async throws -> GameDetail
}
