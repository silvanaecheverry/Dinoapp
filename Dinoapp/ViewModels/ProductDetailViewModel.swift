import SwiftUI

@Observable
class ProductDetailViewModel {
    let product: Product
    var seller: User?
    var showBuyFlow: Bool = false

    init(product: Product) {
        self.product = product
        self.seller = MockDataService.shared.seller(for: product)
    }

    var priceFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "COP"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "es_CO")
        return formatter.string(from: NSNumber(value: product.price)) ?? "$\(product.price)"
    }

    var copFormatted: String {
        product.price.copFormatted
    }

    var timeAgo: String {
        let interval = Date().timeIntervalSince(product.postedDate)
        let days = Int(interval / 86400)
        if days == 0 {
            let hours = Int(interval / 3600)
            if hours == 0 {
                return "Just now"
            }
            return "\(hours)h ago"
        } else if days == 1 {
            return "1 day ago"
        } else if days < 30 {
            return "\(days) days ago"
        } else {
            let months = days / 30
            return months == 1 ? "1 month ago" : "\(months) months ago"
        }
    }
}
