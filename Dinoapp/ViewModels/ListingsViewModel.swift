import SwiftUI

@Observable
class ListingsViewModel {
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    private var userID: UUID {
        appState.currentUser?.id ?? MockDataService.shared.users[0].id
    }

    var listings: [Product] {
        MockDataService.shared.products.filter { $0.sellerID == userID }
    }
}
