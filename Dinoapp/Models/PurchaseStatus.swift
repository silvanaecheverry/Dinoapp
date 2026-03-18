import Foundation

enum PurchaseStatus: String, Codable, Hashable {
    case ready = "Ready"
    case pending = "Pending"
    case expired = "Expired"
    case completed = "Completed"
}
