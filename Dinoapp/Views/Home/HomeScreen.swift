import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Header
                headerView

                // MARK: - Featured For You
                featuredSection

                // MARK: - Sponsored Banner (compact)
                SponsoredBanner(style: .compact(
                    sponsorName: "UniAndes Store",
                    title: "Campus Essentials",
                    description: "Everything you need for finals",
                    ctaText: "Shop",
                    imageName: "bag.fill"
                ))
                .padding(.horizontal, 16)

                // MARK: - Browse Categories
                categoriesSection

                // MARK: - Trending Now
                trendingSection

                // MARK: - Sponsored Banner (large)
                SponsoredBanner(style: .large(
                    title: "Study Fuel Delivered",
                    subtitle: "Order snacks and coffee straight to your dorm",
                    ctaText: "Order Now",
                    imageName: "cup.and.saucer.fill"
                ))
                .padding(.horizontal, 16)

                // MARK: - More Listings
                moreListingsSection

                // MARK: - Sponsored Banner (compact)
                SponsoredBanner(style: .compact(
                    sponsorName: "TechZone",
                    title: "Refurbished Laptops",
                    description: "Certified devices from $1.5M COP",
                    ctaText: "Browse",
                    imageName: "laptopcomputer"
                ))
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 80)
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .navigationDestination(for: String.self) { destination in
            if destination == "notifications" {
                NotificationsScreen()
            }
        }
        .navigationDestination(for: Product.self) { product in
            ProductDetailScreen(product: product)
        }
    }

    // MARK: - Header

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("HEY THERE")
                    .font(DinoFonts.small)
                    .foregroundStyle(DinoColors.mediumGray)
                    .tracking(1)

                Text("Student")
                    .font(DinoFonts.largeTitle)
                    .foregroundStyle(DinoColors.darkText)
            }

            Spacer()

            NavigationLink(value: "notifications") {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 22))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 40, height: 40)

                    Text("3")
                        .font(DinoFonts.micro)
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 16, height: 16)
                        .background(DinoColors.yellow)
                        .clipShape(Circle())
                        .offset(x: 2, y: -2)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    // MARK: - Featured Section

    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DinoSectionHeader(title: "Featured for You", showSeeAll: true)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.featuredProducts) { product in
                        NavigationLink(value: product) {
                            DinoProductCard(
                                product: product,
                                seller: viewModel.seller(for: product),
                                showFavorite: true,
                                style: .featured
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Categories Section

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DinoSectionHeader(title: "Browse Categories", showSeeAll: true)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.categories) { category in
                        CategoryCard(category: category)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Trending Section

    private var trendingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DinoSectionHeader(
                title: "Trending Now",
                icon: "flame.fill",
                showSeeAll: true
            )
            .padding(.horizontal, 16)

            LazyVGrid(columns: gridColumns, spacing: 12) {
                ForEach(viewModel.trendingProducts) { product in
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
    }

    // MARK: - More Listings Section

    private var moreListingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            DinoSectionHeader(title: "More Listings", showSeeAll: true)
                .padding(.horizontal, 16)

            LazyVGrid(columns: gridColumns, spacing: 12) {
                ForEach(viewModel.moreListings) { product in
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
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}
