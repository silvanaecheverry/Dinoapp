import SwiftUI

struct ProductDetailScreen: View {
    let product: Product
    @State private var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(product: Product) {
        self.product = product
        self._viewModel = State(initialValue: ProductDetailViewModel(product: product))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: - Product Image
                    productImageSection

                    // MARK: - Content
                    VStack(alignment: .leading, spacing: 16) {
                        // Title
                        Text(product.title)
                            .font(DinoFonts.semibold(20))
                            .foregroundStyle(DinoColors.darkText)

                        // Price
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text(viewModel.priceFormatted)
                                .font(DinoFonts.bold(26))
                                .foregroundStyle(DinoColors.darkText)
                            Text(" COP")
                                .font(DinoFonts.regular(14))
                                .foregroundStyle(DinoColors.mediumGray)
                        }

                        // Meta row
                        metaRow

                        Divider()

                        // Seller card
                        sellerCard

                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(DinoFonts.semibold(14))
                                .foregroundStyle(DinoColors.darkText)

                            Text(product.description)
                                .font(DinoFonts.regular(14))
                                .foregroundStyle(Color(hex: "374151"))
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        // Safety tip
                        safetyTipCard

                        // Sponsored ad
                        SponsoredBanner(style: .compact(
                            sponsorName: "UniAndes Store",
                            title: "Campus Essentials",
                            description: "Everything you need for finals",
                            ctaText: "Shop",
                            imageName: "bag.fill"
                        ))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                .padding(.bottom, 140)
            }
            .background(Color.white)

            // MARK: - Bottom Buttons
            bottomBar
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .overlay(alignment: .top) {
            navigationBar
        }
        .sheet(isPresented: $viewModel.showBuyFlow) {
            BuyFlowSheet(product: product, seller: viewModel.seller)
        }
    }

    // MARK: - Navigation Bar

    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(DinoColors.darkText)
                    .frame(width: 36, height: 36)
                    .background(DinoColors.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(DinoColors.cardBorder, lineWidth: 1)
                    )
            }

            Spacer()

            HStack(spacing: 8) {
                navBarButton(icon: "square.and.arrow.up")
                navBarButton(icon: "heart")
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private func navBarButton(icon: String) -> some View {
        Button {} label: {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(DinoColors.darkText)
                .frame(width: 36, height: 36)
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
        }
    }

    // MARK: - Product Image

    private var productImageSection: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 0)
                .fill(DinoColors.cardBackground)
                .frame(height: 280)
                .overlay {
                    Image(systemName: product.imageSystemName)
                        .font(.system(size: 64))
                        .foregroundStyle(DinoColors.mediumGray)
                }

            HStack {
                // Condition pill
                HStack(spacing: 4) {
                    Circle()
                        .fill(DinoColors.green)
                        .frame(width: 6, height: 6)
                    Text(product.condition.rawValue)
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.darkText)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.white.opacity(0.9))
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.08), radius: 4, y: 2)

                Spacer()

                // Verified pill
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(DinoColors.darkText)
                    Text("Verified")
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.darkText)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(DinoColors.yellow)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }

    // MARK: - Meta Row

    private var metaRow: some View {
        HStack(spacing: 8) {
            Text(product.category.rawValue)
                .font(DinoFonts.callout)
                .foregroundStyle(DinoColors.darkText)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(DinoColors.cardBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )

            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 11))
                    .foregroundStyle(DinoColors.mediumGray)
                Text("Uniandes Campus")
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.mediumGray)
            }

            Spacer()

            Text(viewModel.timeAgo)
                .font(DinoFonts.caption)
                .foregroundStyle(DinoColors.mediumGray)
        }
    }

    // MARK: - Seller Card

    private var sellerCard: some View {
        HStack(spacing: 12) {
            if let seller = viewModel.seller {
                DinoAvatarView(initial: seller.avatarInitial, size: 44)

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(seller.name)
                            .font(DinoFonts.semibold(14))
                            .foregroundStyle(DinoColors.darkText)
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(DinoColors.yellow)
                    }
                    Text(seller.major)
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(DinoColors.yellow)
                        Text(String(format: "%.1f", seller.rating))
                            .font(DinoFonts.semibold(14))
                            .foregroundStyle(DinoColors.darkText)
                    }
                    Text("\(seller.completedSales) reviews")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }
            }
        }
        .padding(12)
        .frame(minHeight: 74)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    // MARK: - Safety Tip Card

    private var safetyTipCard: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "shield.fill")
                .font(.system(size: 16))
                .foregroundStyle(DinoColors.yellow)

            Text("Always complete transactions on campus. Use the locker system for safe pickup.")
                .font(DinoFonts.caption)
                .foregroundStyle(DinoColors.bodyText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .background(DinoColors.yellow.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.yellow.opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: - Bottom Bar

    private var bottomBar: some View {
        VStack(spacing: 8) {
            Button {
                viewModel.showBuyFlow = true
            } label: {
                Text("Buy Now \u{00B7} \(viewModel.copFormatted)")
                    .font(DinoFonts.semibold(16))
                    .foregroundStyle(DinoColors.darkText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(DinoColors.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }

            Button {} label: {
                Text("Chat with Seller")
                    .font(DinoFonts.medium(14))
                    .foregroundStyle(Color(hex: "374151"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(DinoColors.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(DinoColors.cardBorder, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 24)
        .background(.white)
        .overlay(alignment: .top) {
            Divider()
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailScreen(product: MockDataService.shared.products[0])
    }
}
