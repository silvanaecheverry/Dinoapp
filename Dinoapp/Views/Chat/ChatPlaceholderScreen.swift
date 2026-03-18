import SwiftUI

struct ChatPlaceholderScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Spacer()

                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(DinoColors.yellow)

                Text("Coming Soon")
                    .font(DinoFonts.title)
                    .foregroundStyle(DinoColors.darkText)

                Text("Chat feature will be available in a future update")
                    .font(DinoFonts.body)
                    .foregroundStyle(DinoColors.bodyText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Messages")
        }
    }
}

#Preview {
    ChatPlaceholderScreen()
}
