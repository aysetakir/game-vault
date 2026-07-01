import Foundation

enum AppConfig {
    static let rawgAccessToken: String = {
        guard
            let token = Bundle.main.object(forInfoDictionaryKey: "RAWG_ACCESS_TOKEN") as? String,
            !token.isEmpty
        else {
            fatalError("RAWG_ACCESS_TOKEN bulunamadı. Secrets.xcconfig zincirini kontrol et.")
        }
        return token
    }()
}
