import SwiftUI

struct DinoProductCard: View {
    let product: Product
    var seller: User?
    var showFavorite: Bool = true
    var style: CardStyle = .grid

    enum CardStyle {
        case grid, featured
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image placeholder
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 0)
                    .fill(DinoColors.lightGray)
                    .frame(height: style == .featured ? 120 : 110)
                    .overlay {
                        Image(systemName: product.imageSystemName)
                            .font(.system(size: 36))
                            .foregroundStyle(DinoColors.mediumGray)
                    }

                if product.isFeatured && style == .featured {
                    DinoBadge(text: "Featured")
                        .padding(8)
                }

                if showFavorite {
                    HStack {
                        Spacer()
                        Button {} label: {
                            Image(systemName: "heart")
                                .font(.system(size: 14))
                                .foregroundStyle(DinoColors.mediumGray)
                                .frame(width: 24, height: 24)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
                        }
                        .padding(8)
                    }
                }
            }

            // Info
            VStack(alignment: .leading, spacing: 4) {
                if style == .featured {
                    Text(product.condition.rawValue)
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                        .textCase(.uppercase)
                        .tracking(0.3)
                }

                Text(product.title)
                    .font(style == .featured ? DinoFonts.subheadline : DinoFonts.callout)
                    .foregroundStyle(DinoColors.darkText)
                    .lineLimit(1)

                HStack(spacing: 0) {
                    Text(product.priceFormatted.replacingOccurrences(of: " COP", with: ""))
                        .font(DinoFonts.bold(14))
                        .foregroundStyle(DinoColors.darkText)
                    Text(" COP")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }

                if let seller {
                    HStack {
                        if style == .featured {
                            DinoAvatarView(initial: seller.avatarInitial)
                            Text(seller.shortName)
                                .font(DinoFonts.caption)
                                .foregroundStyle(DinoColors.bodyText)
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(DinoColors.yellow)
                        } else {
                            Text(seller.shortName)
                                .font(DinoFonts.small)
                                .foregroundStyle(DinoColors.mediumGray)
                            Spacer()
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                    .foregroundStyle(DinoColors.yellow)
                                Text(String(format: "%.1f", seller.rating))
                                    .font(DinoFonts.small)
                                    .foregroundStyle(DinoColors.bodyText)
                            }
                        }
                    }
                }
            }
            .padding(style == .featured ? 12 : 10)
        }
        .dinoCard()
        .frame(width: style == .featured ? 200 : nil)
    }
}
