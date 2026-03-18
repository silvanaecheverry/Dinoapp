import SwiftUI

struct SettingsScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Notifications
                Section("Notifications") {
                    SettingsToggleRow(
                        icon: "bell.fill",
                        title: "Push Notifications",
                        isOn: $viewModel.pushNotifications
                    )
                    SettingsToggleRow(
                        icon: "envelope.fill",
                        title: "Email Notifications",
                        isOn: $viewModel.emailNotifications
                    )
                }

                // MARK: - Preferences
                Section("Preferences") {
                    SettingsToggleRow(
                        icon: "moon.fill",
                        title: "Dark Mode",
                        isOn: $viewModel.darkMode
                    )
                    SettingsToggleRow(
                        icon: "location.fill",
                        title: "Location Services",
                        isOn: $viewModel.locationServices
                    )
                }

                // MARK: - Account
                Section("Account") {
                    SettingsNavigationRow(icon: "person.fill", title: "Edit Profile")
                    SettingsNavigationRow(icon: "lock.fill", title: "Change Password")
                }

                // MARK: - Support
                Section("Support") {
                    SettingsNavigationRow(icon: "questionmark.circle.fill", title: "Help Center")
                    SettingsNavigationRow(icon: "exclamationmark.triangle.fill", title: "Report a Problem")
                    SettingsNavigationRow(icon: "doc.text.fill", title: "Terms of Service")
                }

                // MARK: - Danger Zone
                Section("Danger Zone") {
                    Button {
                        appState.currentScreen = .login
                        appState.isLoggedIn = false
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundStyle(.red)
                            Text("Log Out")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
        .environment(AppState())
}
