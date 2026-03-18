import SwiftUI

struct DinoSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search products..."

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(DinoColors.mediumGray)
                .font(.system(size: 16))
            TextField(placeholder, text: $text)
                .font(DinoFonts.body)
                .foregroundStyle(DinoColors.darkText)
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(DinoColors.mediumGray)
                }
            }
        }
        .padding(.horizontal, 14)
        .frame(height: 44)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }
}
