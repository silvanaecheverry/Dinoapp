import SwiftUI

struct DinoChip: View {
    let title: String
    var isSelected: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .font(DinoFonts.callout)
                .foregroundStyle(isSelected ? DinoColors.darkText : DinoColors.mediumGray)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? DinoColors.yellow : DinoColors.cardBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : DinoColors.cardBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}
