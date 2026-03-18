import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 4) {
            // Logo placeholder
            RoundedRectangle(cornerRadius: 24)
                .fill(DinoColors.yellow)
                .frame(width: 100, height: 100)
                .overlay {
                    Image(systemName: "cart.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(DinoColors.darkText)
                }
                .padding(.bottom, 12)

            Text("Dino")
                .font(DinoFonts.largeTitle)
                .foregroundStyle(DinoColors.darkText)
                .tracking(-0.7)

            Text("Universidad de los Andes")
                .font(DinoFonts.body)
                .foregroundStyle(DinoColors.mediumGray)

            DinoLoadingDots()
                .padding(.top, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    SplashScreen()
}
