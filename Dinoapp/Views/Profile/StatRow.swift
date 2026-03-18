import SwiftUI

struct StatRow: View {
    let rating: String
    let activeListings: String
    let completedSales: String

    var body: some View {
        HStack(spacing: 0) {
            statItem(icon: "star.fill", value: rating, label: "Rating")

            divider

            statItem(icon: "tag.fill", value: activeListings, label: "Listings")

            divider

            statItem(icon: "checkmark.circle.fill", value: completedSales, label: "Sales")
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    private func statItem(icon: String, value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(DinoColors.yellow)
            Text(value)
                .font(DinoFonts.semibold(18))
                .foregroundStyle(DinoColors.darkText)
            Text(label)
                .font(DinoFonts.caption)
                .foregroundStyle(DinoColors.mediumGray)
        }
        .frame(maxWidth: .infinity)
    }

    private var divider: some View {
        Rectangle()
            .fill(DinoColors.cardBorder)
            .frame(width: 1, height: 40)
    }
}
