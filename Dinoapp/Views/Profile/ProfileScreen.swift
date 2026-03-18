import SwiftUI

struct ProfileScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: ProfileViewModel?

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Avatar and user info
                VStack(spacing: 8) {
                    DinoAvatarView(initial: user.avatarInitial, size: 80)

                    Text(user.name)
                        .font(DinoFonts.title)
                        .foregroundStyle(DinoColors.darkText)

                    Text(user.email)
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }
                .padding(.top, 16)

                // Stats row
                StatRow(
                    rating: resolvedViewModel.rating,
                    activeListings: resolvedViewModel.activeListings,
                    completedSales: resolvedViewModel.completedSales
                )
                .padding(.horizontal, 16)

                // Menu items
                VStack(spacing: 0) {
                    NavigationLink(value: ProfileDestination.purchases) {
                        menuRow(icon: "bag.fill", title: "My Purchases")
                    }

                    menuDivider

                    NavigationLink(value: ProfileDestination.listings) {
                        menuRow(icon: "tag.fill", title: "My Listings")
                    }

                    menuDivider

                    NavigationLink(value: ProfileDestination.notifications) {
                        menuRow(icon: "bell.fill", title: "Notifications")
                    }

                    menuDivider

                    NavigationLink(value: ProfileDestination.settings) {
                        menuRow(icon: "gearshape.fill", title: "Settings")
                    }
                }
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 80)
        }
        .background(Color.white)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: ProfileDestination.self) { destination in
            switch destination {
            case .purchases:
                MyPurchasesScreen()
            case .listings:
                MyListingsScreen()
            case .notifications:
                NotificationsScreen()
            case .settings:
                SettingsScreen()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ProfileViewModel(appState: appState)
            }
        }
    }

    private var user: User {
        resolvedViewModel.user
    }

    private var resolvedViewModel: ProfileViewModel {
        viewModel ?? ProfileViewModel(appState: appState)
    }

    private func menuRow(icon: String, title: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(DinoColors.darkText)
                .frame(width: 24)

            Text(title)
                .font(DinoFonts.body)
                .foregroundStyle(DinoColors.darkText)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(DinoColors.mediumGray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }

    private var menuDivider: some View {
        Divider()
            .padding(.leading, 52)
    }
}

enum ProfileDestination: Hashable {
    case purchases
    case listings
    case notifications
    case settings
}
