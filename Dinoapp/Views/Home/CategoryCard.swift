import SwiftUI

struct CategoryCard: View {
    let category: Category
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(DinoColors.yellow.opacity(0.15))
                    .frame(width: 48, height: 48)
                    .overlay {
                        Image(systemName: category.iconName)
                            .font(.system(size: 20))
                            .foregroundStyle(DinoColors.darkText)
                    }

                Text(category.rawValue)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.darkText)
                    .lineLimit(1)
            }
            .frame(width: 76)
            .padding(.vertical, 12)
            .padding(.horizontal, 4)
            .background(DinoColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(DinoColors.cardBorder, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
