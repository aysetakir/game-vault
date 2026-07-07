 
    import SwiftUI

    struct GameDetailView: View {
        @State private var viewModel: GameDetailViewModel

        init(viewModel: GameDetailViewModel) {
            _viewModel = State(initialValue: viewModel)
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
            .task {
                await viewModel.loadDetail()
            }
        }
    }

