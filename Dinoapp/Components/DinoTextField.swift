import SwiftUI

struct DinoTextField: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var axis: Axis = .horizontal

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(DinoFonts.callout)
                .foregroundStyle(DinoColors.bodyText)
            TextField(placeholder, text: $text, axis: axis)
                .font(DinoFonts.body)
                .foregroundStyle(DinoColors.darkText)
                .padding(12)
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
        }
    }
}
