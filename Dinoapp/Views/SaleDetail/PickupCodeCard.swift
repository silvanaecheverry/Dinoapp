import SwiftUI

struct PickupCodeCard: View {
    let digits: [String]
    let onCopy: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Description text
            Text("Share this code with the buyer when they confirm pickup")
                .font(DinoFonts.caption)
                .foregroundStyle(DinoColors.bodyText)
                .fixedSize(horizontal: false, vertical: true)

            // Digits row + copy button
            HStack(spacing: 6) {
                // Individual digit boxes
                ForEach(Array(digits.enumerated()), id: \.offset) { _, digit in
                    Text(digit)
                        .font(DinoFonts.bold(18))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 36, height: 40)
                        .background(Color(hex: "FAFAF7"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(DinoColors.cardBorder, lineWidth: 1)
                        )
                }

                Spacer()

                // Copy button
                Button(action: onCopy) {
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 40, height: 40)
                        .background(DinoColors.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
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
