import SwiftUI

struct BuyerInfoCard: View {
    let buyer: User

    var body: some View {
        HStack(spacing: 12) {
            // Avatar with initials (44pt, rounded 16pt)
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(DinoColors.darkBackground)
                    .frame(width: 44, height: 44)
                Text(buyer.avatarInitial)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }

            // Name and major
            VStack(alignment: .leading, spacing: 2) {
                Text(buyer.name)
                    .font(DinoFonts.subheadline)
                    .foregroundStyle(DinoColors.darkText)
                Text(buyer.major)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.bodyText)
            }

            Spacer()

            // Rating
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(DinoColors.yellow)
                Text(String(format: "%.1f", buyer.rating))
                    .font(DinoFonts.subheadline)
                    .foregroundStyle(DinoColors.darkText)
            }
        }
        .padding(16)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }
}
