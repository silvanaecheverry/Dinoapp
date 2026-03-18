import SwiftUI

@Observable
class PurchasesViewModel {
    var selectedTab: PurchaseTab = .active

    enum PurchaseTab: String, CaseIterable {
        case active = "Active"
        case completed = "Completed"
    }

    var purchases: [Purchase] {
        MockDataService.shared.purchases
    }

    var filteredPurchases: [Purchase] {
        switch selectedTab {
        case .active:
            return purchases.filter { $0.status == .ready || $0.status == .pending }
        case .completed:
            return purchases.filter { $0.status == .completed || $0.status == .expired }
        }
    }

    func product(for purchase: Purchase) -> Product? {
        MockDataService.shared.product(for: purchase)
    }

    func seller(for purchase: Purchase) -> User? {
        MockDataService.shared.users.first { $0.id == purchase.sellerID }
    }
}
