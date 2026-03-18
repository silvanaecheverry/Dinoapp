import SwiftUI

struct SearchScreen: View {
    @State private var viewModel = SearchViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text("Explore")
                    .font(DinoFonts.title)
                    .foregroundStyle(DinoColors.darkText)
                    .padding(.horizontal, 16)

                // Search bar
                DinoSearchBar(text: $viewModel.searchText, placeholder: "Search products...")
                    .padding(.horizontal, 16)

                // Category filter chips
                CategoryFilterChips(selectedCategory: $viewModel.selectedCategory)

                // Results count
                Text("\(viewModel.filteredProducts.count) items found")
                    .font(DinoFonts.callout)
                    .foregroundStyle(DinoColors.mediumGray)
                    .padding(.horizontal, 16)

                // Product grid
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.filteredProducts) { product in
                        NavigationLink(value: product) {
                            DinoProductCard(
                                product: product,
                                seller: viewModel.seller(for: product),
                                showFavorite: true,
                                style: .grid
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 8)
            .padding(.bottom, 80)
        }
        .background(.white)
        .navigationDestination(for: Product.self) { product in
            ProductDetailScreen(product: product)
        }
    }
}

#Preview {
    SearchScreen()
}
