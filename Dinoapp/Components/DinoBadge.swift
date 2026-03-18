import SwiftUI

struct DinoBadge: View {
    let text: String
    var color: Color = DinoColors.yellow

    var body: some View {
        Text(text)
            .font(DinoFonts.micro)
            .tracking(0.25)
            .textCase(.uppercase)
            .foregroundStyle(textColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color)
            .clipShape(Capsule())
    }

    private var textColor: Color {
        if color == DinoColors.green || color == DinoColors.red {
            return .white
        }
        return DinoColors.darkText
    }
}
