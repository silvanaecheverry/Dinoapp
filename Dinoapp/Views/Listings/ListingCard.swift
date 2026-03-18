import SwiftUI

struct ListingCard: View {
    let product: Product

    var body: some View {
        HStack(spacing: 12) {
            // Product image placeholder (72pt, 10pt radius)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(DinoColors.lightGray)
                    .frame(width: 72, height: 72)
                Image(systemName: product.imageSystemName)
                    .font(.system(size: 26))
                    .foregroundStyle(DinoColors.mediumGray)

                // Sold overlay
                if product.status == .sold {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.6))
                        .frame(width: 72, height: 72)
                    Text("SOLD")
                        .font(DinoFonts.bold(12))
                        .foregroundStyle(.white)
                }
            }

            // Info section
            VStack(alignment: .leading, spacing: 4) {
                // Title row with edit button
                HStack {
                    Text(product.title)
                        .font(DinoFonts.subheadline)
                        .foregroundStyle(DinoColors.darkText)
                        .lineLimit(1)

                    Spacer()

                    Button {
                        // Edit action
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 14))
                            .foregroundStyle(DinoColors.mediumGray)
                            .frame(width: 28, height: 28)
                    }
                }

                // Price + Status badge
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text(priceNumber)
                            .font(DinoFonts.bold(14))
                            .foregroundStyle(DinoColors.darkText)
                        Text("COP")
                            .font(DinoFonts.caption)
                            .foregroundStyle(DinoColors.mediumGray)
                    }

                    statusBadge
                }

                // Views count
                HStack(spacing: 4) {
                    Image(systemName: "eye")
                        .font(.system(size: 11))
                        .foregroundStyle(DinoColors.mediumGray)
                    Text("\(product.viewsCount) views")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.bodyText)
                }

                // Date
                Text(product.postedDate.formatted(date: .abbreviated, time: .omitted))
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.mediumGray)
            }
        }
        .padding(16)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: product.status == .reserved ? 1.5 : 1)
        )
    }

    // MARK: - Status Badge

    @ViewBuilder
    private var statusBadge: some View {
        Text(statusText)
            .font(DinoFonts.micro)
            .tracking(0.25)
            .foregroundStyle(statusTextColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(statusBgColor)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(statusBorderColor, lineWidth: statusHasBorder ? 1 : 0)
            )
    }

    private var statusText: String {
        switch product.status {
        case .active: return "Active"
        case .sold: return "Sold"
        case .reserved: return "Sale Pending"
        case .expired: return "Expired"
        }
    }

    private var statusTextColor: Color {
        switch product.status {
        case .active: return DinoColors.green
        case .sold: return DinoColors.bodyText
        case .reserved: return DinoColors.darkText
        case .expired: return DinoColors.red
        }
    }

    private var statusBgColor: Color {
        switch product.status {
        case .active: return DinoColors.green.opacity(0.15)
        case .sold: return Color(hex: "FAFAF7")
        case .reserved: return Color(hex: "F4D03F")
        case .expired: return DinoColors.red.opacity(0.1)
        }
    }

    private var statusBorderColor: Color {
        switch product.status {
        case .active: return DinoColors.green
        case .sold: return DinoColors.mediumGray
        case .reserved: return .clear
        case .expired: return DinoColors.red
        }
    }

    private var statusHasBorder: Bool {
        switch product.status {
        case .reserved: return false
        default: return true
        }
    }

    private var borderColor: Color {
        switch product.status {
        case .reserved: return Color(hex: "F4D03F")
        default: return DinoColors.cardBorder
        }
    }

    private var priceNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.locale = Locale(identifier: "es_CO")
        return "$" + (formatter.string(from: NSNumber(value: product.price)) ?? "\(product.price)")
    }
}
