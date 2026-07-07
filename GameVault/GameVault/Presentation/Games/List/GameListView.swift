import SwiftUI

struct GameListView: View {
    @State private var viewModel: GameListViewModel
    private let repository: GameRepository

    init(viewModel: GameListViewModel, repository: GameRepository) {
        _viewModel = State(initialValue: viewModel)
        self.repository = repository
    }

    var body: some View {
        NavigationStack {
            List(viewModel.games) { game in
                NavigationLink {
                    GameDetailView(
                        viewModel: GameDetailViewModel(repository: repository, gameId: game.id)
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
