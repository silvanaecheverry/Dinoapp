import SwiftUI

struct PurchaseCard: View {
    let purchase: Purchase
    let product: Product?
    let seller: User?

    var body: some View {
        HStack(spacing: 12) {
            // Product image placeholder (72pt, 10pt radius)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(DinoColors.lightGray)
                    .frame(width: 72, height: 72)
                Image(systemName: product?.imageSystemName ?? "shippingbox.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(DinoColors.mediumGray)
            }

            // Info section
            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(product?.title ?? "Unknown Product")
                    .font(DinoFonts.subheadline)
                    .foregroundStyle(DinoColors.darkText)
                    .lineLimit(1)

                // Status badge
                statusBadge

                // Price
                HStack(spacing: 4) {
                    Text(priceNumber)
                        .font(DinoFonts.bold(14))
                        .foregroundStyle(DinoColors.darkText)
                    Text("COP")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }

                // Seller name
                if let seller {
                    Text("Seller: \(seller.shortName)")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.bodyText)
                }

                // Locker info
                Text(purchase.lockerLocation)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.bodyText)
                    .lineLimit(1)

                // Date
                Text(purchase.purchaseDate.formatted(date: .abbreviated, time: .omitted))
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.mediumGray)
            }

            Spacer()

            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(DinoColors.mediumGray)
        }
        .padding(16)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: purchase.status == .ready ? 1.5 : 1)
        )
    }

    // MARK: - Status Badge

    @ViewBuilder
    private var statusBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: badgeIcon)
                .font(.system(size: 10))
            Text(badgeText)
                .font(DinoFonts.micro)
                .tracking(0.25)
        }
        .foregroundStyle(DinoColors.darkText)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(badgeBackground)
        .clipShape(Capsule())
    }

    private var badgeText: String {
        switch purchase.status {
        case .ready: return "Ready!"
        case .pending: return "Pending"
        case .expired: return "Expired"
        case .completed: return "Completed"
        }
    }

    private var badgeIcon: String {
        switch purchase.status {
        case .ready: return "checkmark"
        case .pending: return "clock"
        case .expired: return "exclamationmark.triangle"
        case .completed: return "checkmark.circle"
        }
    }

    private var badgeBackground: Color {
        switch purchase.status {
        case .ready: return DinoColors.yellow
        case .pending: return Color(hex: "F5F5F0")
        case .expired: return Color(hex: "FEE2E2")
        case .completed: return Color(hex: "F5F5F0")
        }
    }

    private var borderColor: Color {
        switch purchase.status {
        case .ready: return Color(hex: "F4D03F")
        default: return DinoColors.cardBorder
        }
    }

    private var priceNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.locale = Locale(identifier: "es_CO")
        return "$" + (formatter.string(from: NSNumber(value: product?.price ?? 0)) ?? "\(product?.price ?? 0)")
    }
}
