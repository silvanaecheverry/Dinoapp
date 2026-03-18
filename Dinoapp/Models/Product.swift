import Foundation

struct Product: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var description: String
    var price: Int
    var category: Category
    var condition: Condition
    var status: ProductStatus
    var sellerID: UUID
    var isFeatured: Bool
    var imageSystemName: String
    var postedDate: Date
    var viewsCount: Int = 0

    var priceFormatted: String {
        price.copFormatted
    }
}
