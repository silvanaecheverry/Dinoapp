import Foundation

struct Purchase: Identifiable, Hashable, Codable {
    let id: UUID
    var productID: UUID
    var buyerID: UUID
    var sellerID: UUID
    var status: PurchaseStatus
    var lockerCode: String
    var lockerLocation: String
    var purchaseDate: Date
    var expiryDate: Date
}
