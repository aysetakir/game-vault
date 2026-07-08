import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModel
    private let repository: GameRepository
    private let favoritesViewModel: FavoritesGameViewModel

    init(viewModel: SearchViewModel, repository: GameRepository, favoritesViewModel: FavoritesGameViewModel) {
        _viewModel = State(initialValue: viewModel)
        self.repository = repository
        self.favoritesViewModel = favoritesViewModel
    }

    var body: some View {
        NavigationStack {
            List(viewModel.results) { game in
                NavigationLink {
                    GameDetailView(
                        viewModel: GameDetailViewModel(repository: repository, gameId: game.id),
                        favoritesViewModel: favoritesViewModel
                    )
                } label: {
                    HStack {
                        AsyncImage(url: game.backgroundImage) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFill()
                            } else if phase.error != nil {
                                Color.red
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 60, height: 60)
                        .clipped()

                        VStack(alignment: .leading) {
                            Text(game.name).font(.headline)
                            Text(String(format: "%.1f", game.rating))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.results.isEmpty && !viewModel.query.isEmpty {
                    ContentUnavailableView("Sonuç yok", systemImage: "magnifyingglass")
                }
            }
            .navigationTitle("Ara")
            .searchable(text: $viewModel.query, prompt: "Oyun ara")
        }
    }
}
