# GameVault

A SwiftUI game discovery app built on the RAWG API. Browse, search, view details, and favorite games.

Built to reinforce the Clean Architecture + MVVM setup from my TMDB-based movie-discovery app, this time on a different API (RAWG).

## Features

- Paginated (infinite scroll) list of popular games
- Game detail screen (description, rating, Metacritic, release date, website)
- Debounced search (single request on typing pause, with `Task` cancellation)
- Persistent favorites via SwiftData, synced between list and detail screens
- Cover images with `AsyncImage`
- Tab-based navigation (Games / Search)

## Architecture

Clean Architecture + MVVM:

- **App** — composition root (dependency wiring)
- **Core** — networking (`Endpoint`, `APIClient`, `NetworkError`)
- **Domain** — pure models (`Game`, `GamePage`, `GameDetail`) + repository protocol
- **Data** — DTOs, mappers, repository implementation, SwiftData `@Model`
- **Presentation** — `@Observable` view models + SwiftUI views

Flow: `DTO (API)` → `Entity (Domain)` → SwiftData `@Model (favorites)`, via mappers. Repository protocol lives in Domain, implementation in Data — views depend on the protocol, not the concrete type (DI).

## Tech

- Swift, SwiftUI (iOS 17+)
- async/await
- `@Observable` (Observation framework)
- SwiftData
- URLSession, Codable

## Setup

The RAWG API key is read from a `Secrets.xcconfig` file, which is **not** committed. Create it before running:

1. Get a RAWG API key: https://rawg.io/apidocs
2. Create `Secrets.xcconfig` with:

   ```
   RAWG_ACCESS_TOKEN = your_key_here
   ```

3. Ensure the `.xcconfig` is linked to the target and `Info.plist`'s `RAWG_ACCESS_TOKEN` maps to `$(RAWG_ACCESS_TOKEN)`.
4. Build and run in Xcode.

## Notes

RAWG data and images belong to RAWG. For personal/educational use.
