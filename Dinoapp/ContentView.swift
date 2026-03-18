import SwiftUI

struct ContentView: View {
    var body: some View {
        AppCoordinator(appState: AppState())
    }
}

#Preview {
    ContentView()
}
