import SwiftUI

struct DinoSectionHeader: View {
    let title: String
    var icon: String? = nil
    var showSeeAll: Bool = false
    var onSeeAll: (() -> Void)? = nil

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundStyle(DinoColors.darkText)
                }
                Text(title)
                    .font(DinoFonts.headline)
                    .foregroundStyle(DinoColors.darkText)
            }
            Spacer()
            if showSeeAll {
                Button {
                    onSeeAll?()
                } label: {
                    Text("See all")
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.mediumGray)
                }
            }
        }
    }
}
