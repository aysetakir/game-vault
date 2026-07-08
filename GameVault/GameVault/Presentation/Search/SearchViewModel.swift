import Foundation

@MainActor
@Observable
final class SearchViewModel {
    var query: String = "" {
        didSet { scheduleSearch() }
    }
    
    private(set) var results: [Game] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private let repository: GameRepository
    private var searchTask: Task<Void, Never>?
    
    init(repository: GameRepository) {
        self.repository = repository
    }
    
    private func scheduleSearch() {
        searchTask?.cancel()
        
        let currentQuery = query.trimmingCharacters(in: .whitespaces)
        
        guard !currentQuery.isEmpty else {
            results = []
            return
        }
        
        searchTask = Task {
            do {
                try await Task.sleep(for: .milliseconds(500))
                try Task.checkCancellation()
                
                isLoading = true
                let page = try await repository.searchGames(query: currentQuery, page: 1)
                results = page.games
                isLoading = false
            } catch is CancellationError {
                print("iptal edildi")
            } catch {
                errorMessage = "arama yapılamadı"
                isLoading = false
            }
        }
    }
    
}
