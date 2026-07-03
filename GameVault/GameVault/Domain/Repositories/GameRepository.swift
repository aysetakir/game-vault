protocol GameRepository {
    func fetchGames(page: Int) async throws -> GamePage
}
