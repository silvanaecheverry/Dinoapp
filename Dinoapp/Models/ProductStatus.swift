import Foundation

enum ProductStatus: String, Codable, Hashable {
    case active = "Active"
    case sold = "Sold"
    case reserved = "Reserved"
    case expired = "Expired"
}
