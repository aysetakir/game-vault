
import SwiftUI

struct GameDetailView: View {
    @State private var viewModel: GameDetailViewModel
    private let favoritesViewModel: FavoritesGameViewModel
    
    init(viewModel: GameDetailViewModel, favoritesViewModel: FavoritesGameViewModel) {
        _viewModel = State(initialValue: viewModel)
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        ScrollView {
            if let detail = viewModel.detail {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: detail.backgroundImage) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFill()
                        } else if phase.error != nil {
                            Color.gray
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(detail.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 16) {
                            Label(String(format: "%.1f", detail.rating), systemImage: "star.fill")
                                .foregroundStyle(.orange)
                            if let metacritic = detail.metacritic {
                                Text("Metacritic: \(metacritic)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .font(.subheadline)
                        
                        if let released = detail.released {
                            Text("Çıkış: \(released)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        if let description = detail.description, !description.isEmpty {
                            Text(description)
                                .font(.body)
                        }
                        
                        if let website = detail.website {
                            Link("Resmi Site", destination: website)
                                .font(.subheadline)
                        }
                    }
                    .padding(.horizontal)
                }
            } else if viewModel.errorMessage != nil {
                Text(viewModel.errorMessage ?? "")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                ProgressView()
                    .padding(.top, 100)
            }
        }
        .navigationTitle(viewModel.detail?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let detail = viewModel.detail {
                Button {
                    favoritesViewModel.toggleFavorite(id: detail.id, name: detail.name, backgroundImage: detail.backgroundImage?.absoluteString, rating: detail.rating)
                } label: {
                    Image(systemName: favoritesViewModel.isFavorite(id: detail.id) ? "heart.fill" : "heart")
                        .foregroundStyle(.red)
                }
                
            }
        }
        .task {
            await viewModel.loadDetail()
        }
    }
}

