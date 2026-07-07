import SwiftUI

struct GameListView: View {
    @State private var viewModel: GameListViewModel
    
    init(viewModel: GameListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.games) { game in
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
                    Task {
                        await viewModel.loadGames()
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .task {
            await viewModel.loadGames()
        }
    }
}
