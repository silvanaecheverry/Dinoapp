import SwiftUI

@Observable
class ProfileViewModel {
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    var user: User {
        appState.currentUser ?? MockDataService.shared.users[0]
    }

    var rating: String {
        String(format: "%.1f", user.rating)
    }

    var activeListings: String {
        "\(user.activeListings)"
    }

    var completedSales: String {
        "\(user.completedSales)"
    }
}
