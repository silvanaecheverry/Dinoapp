import SwiftUI

struct LoginScreen: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        VStack(spacing: 0) {
            // Hero image area
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [DinoColors.yellow.opacity(0.3), DinoColors.lightGray],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 340)
                    .overlay {
                        Image(systemName: "graduationcap.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(DinoColors.mediumGray.opacity(0.4))
                    }

                // Gradient overlay
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [.clear, .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 100)
                }
                .frame(height: 340)

                // Logo pill
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(DinoColors.yellow)
                        .frame(width: 28, height: 28)
                        .overlay {
                            Text("U")
                                .font(DinoFonts.bold(14))
                                .foregroundStyle(DinoColors.darkText)
                        }
                    Text("Dino")
                        .font(DinoFonts.subheadline)
                        .foregroundStyle(DinoColors.darkText)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.white.opacity(0.9))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                .padding(.top, 48)
            }

            // Content
            VStack(alignment: .leading, spacing: 24) {
                // Title
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Buy & sell across")
                            .font(DinoFonts.largeTitle)
                            .foregroundStyle(DinoColors.darkText)
                        Text("your campus")
                            .font(DinoFonts.largeTitle)
                            .foregroundStyle(DinoColors.yellow)
                    }

                    Text("The exclusive marketplace for Universidad de los Andes students.")
                        .font(.system(size: 15))
                        .foregroundStyle(DinoColors.bodyText)
                        .lineSpacing(4)
                }

                // Feature list
                VStack(alignment: .leading, spacing: 12) {
                    featureRow("Verified @uniandes.edu.co accounts only")
                    featureRow("Campus locker pickup system")
                    featureRow("Safe, peer-to-peer transactions")
                }

                Spacer()

                // Sign in button
                VStack(spacing: 12) {
                    DinoButton(title: "Sign in with Uniandes Email", icon: "envelope.fill") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            appState.login()
                        }
                    }

                    Text("Only @uniandes.edu.co emails are accepted")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
        }
        .ignoresSafeArea(edges: .top)
        .background(.white)
    }

    private func featureRow(_ text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(DinoColors.darkText)
                .frame(width: 20, height: 20)
                .background(DinoColors.yellow)
                .clipShape(Circle())
            Text(text)
                .font(DinoFonts.body)
                .foregroundStyle(Color(hex: "374151"))
        }
    }
}

#Preview {
    LoginScreen()
        .environment(AppState())
}
