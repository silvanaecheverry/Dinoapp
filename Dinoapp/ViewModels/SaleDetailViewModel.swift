import SwiftUI
import UIKit

@Observable
class SaleDetailViewModel {
    let purchase: Purchase
    var isMarkedDelivered: Bool = false

    init(purchase: Purchase) {
        self.purchase = purchase
    }

    var product: Product? {
        MockDataService.shared.product(for: purchase)
    }

    var buyer: User? {
        MockDataService.shared.buyer(for: purchase)
    }

    var seller: User? {
        MockDataService.shared.users.first { $0.id == purchase.sellerID }
    }

    var lockerCode: String {
        purchase.lockerCode
    }

    var lockerCodeDigits: [String] {
        purchase.lockerCode.map { String($0) }
    }

    var lockerLocation: String {
        purchase.lockerLocation
    }

    var expiryDateFormatted: String {
        purchase.expiryDate.formatted(date: .abbreviated, time: .shortened)
    }

    var purchaseDateFormatted: String {
        purchase.purchaseDate.formatted(date: .abbreviated, time: .omitted)
    }

    var isExpired: Bool {
        purchase.status == .expired
    }

    var isPending: Bool {
        purchase.status == .pending
    }

    var statusText: String {
        switch purchase.status {
        case .pending: return "Pending Delivery"
        case .ready: return "Ready for Pickup"
        case .completed: return "Completed"
        case .expired: return "Expired"
        }
    }

    var statusIcon: String {
        switch purchase.status {
        case .pending: return "clock"
        case .ready: return "checkmark.circle"
        case .completed: return "checkmark.circle.fill"
        case .expired: return "exclamationmark.triangle"
        }
    }

    var meetupTime: String {
        "Today 2:00 PM"
    }

    func markAsDelivered() {
        isMarkedDelivered = true
    }

    func copyCode() {
        UIPasteboard.general.string = lockerCode
    }
}
