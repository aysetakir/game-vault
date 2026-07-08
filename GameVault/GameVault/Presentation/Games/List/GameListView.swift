import SwiftUI

struct GameListView: View {
    @State private var viewModel: GameListViewModel
    private let repository: GameRepository
    private let favoritesViewModel: FavoritesGameViewModel
    
    init(viewModel: GameListViewModel, repository: GameRepository, favoritesViewModel: FavoritesGameViewModel) {
        _viewModel = State(initialValue: viewModel)
        self.repository = repository
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.games) { game in
                NavigationLink {
                    GameDetailView(
                        viewModel: GameDetailViewModel(repository: repository, gameId: game.id), favoritesViewModel: favoritesViewModel
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
                        .frame(width: 80, height: 80)
                        .clipped()
                        
                        VStack(alignment: .leading) {
                            Text(game.name).font(.headline)
                            Text(String(format: "%.1f", game.rating))
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Button {
                            favoritesViewModel.toggleFavorite(
                                id: game.id,
                                name: game.name,
                                backgroundImage: game.backgroundImage?.absoluteString,
                                rating: game.rating
                            )
                        } label: {
                            Image(systemName: favoritesViewModel.isFavorite(id: game.id) ? "heart.fill" : "heart")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.plain)
                    }
                    .onAppear {
                        if game.id == viewModel.games.last?.id {
                            Task { await viewModel.loadGames() }
                        }
                    }
                }
            }
            .navigationTitle("Oyunlar")
            .scrollIndicators(.hidden)
            .task {
                await viewModel.loadGames()
            }
        }
    }
}
