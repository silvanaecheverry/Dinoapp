import SwiftUI

struct DinoCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(DinoColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(DinoColors.cardBorder, lineWidth: 1)
            )
    }
}

struct DinoPillBadgeModifier: ViewModifier {
    var color: Color = DinoColors.yellow

    func body(content: Content) -> some View {
        content
            .font(DinoFonts.micro)
            .tracking(0.25)
            .textCase(.uppercase)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color)
            .clipShape(Capsule())
    }
}

extension View {
    func dinoCard() -> some View {
        modifier(DinoCardModifier())
    }

    func dinoPillBadge(color: Color = DinoColors.yellow) -> some View {
        modifier(DinoPillBadgeModifier(color: color))
    }
}
