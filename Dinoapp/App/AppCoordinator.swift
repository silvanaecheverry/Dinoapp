import SwiftUI

struct AppCoordinator: View {
    @State var appState: AppState

    var body: some View {
        Group {
            switch appState.currentScreen {
            case .splash:
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                appState.currentScreen = .login
                            }
                        }
                    }
            case .login:
                LoginScreen()
            case .profileSetup:
                ProfileSetupScreen()
            case .main:
                MainTabView()
            }
        }
        .environment(appState)
    }
}
