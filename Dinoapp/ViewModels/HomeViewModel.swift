import SwiftUI

@Observable
class HomeViewModel {
    private let dataService = MockDataService.shared

    var products: [Product] {
        dataService.products
    }

    var featuredProducts: [Product] {
        dataService.featuredProducts
    }

    var trendingProducts: [Product] {
        dataService.trendingProducts
    }

    var categories: [Category] {
        Array(Category.allCases.prefix(4))
    }

    var moreListings: [Product] {
        Array(dataService.products.dropFirst(4))
    }

    func seller(for product: Product) -> User? {
        dataService.seller(for: product)
    }
}
