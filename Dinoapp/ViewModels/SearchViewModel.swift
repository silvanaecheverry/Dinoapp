import SwiftUI

@Observable
class SearchViewModel {
    var searchText: String = ""
    var selectedCategory: Category? = nil

    var allProducts: [Product] {
        MockDataService.shared.products
    }

    var filteredProducts: [Product] {
        allProducts.filter { product in
            let matchesSearch = searchText.isEmpty ||
                product.title.localizedCaseInsensitiveContains(searchText) ||
                product.condition.rawValue.localizedCaseInsensitiveContains(searchText)

            let matchesCategory = selectedCategory == nil ||
                product.category == selectedCategory

            return matchesSearch && matchesCategory
        }
    }

    func seller(for product: Product) -> User? {
        MockDataService.shared.seller(for: product)
    }
}
