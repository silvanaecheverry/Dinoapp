import SwiftUI

enum TabItem: Int, CaseIterable {
    case home, search, add, chat, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .add: return ""
        case .chat: return "Chat"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .search: return "magnifyingglass"
        case .add: return "plus"
        case .chat: return "message.fill"
        case .profile: return "person.fill"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    @State private var showAddProduct = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab content
            Group {
                switch selectedTab {
                case .home:
                    NavigationStack {
                        HomeScreen()
                    }
                case .search:
                    NavigationStack {
                        SearchScreen()
                    }
                case .add:
                    EmptyView()
                case .chat:
                    NavigationStack {
                        ChatPlaceholderScreen()
                    }
                case .profile:
                    NavigationStack {
                        ProfileScreen()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom Tab Bar
            customTabBar
        }
        .sheet(isPresented: $showAddProduct) {
            AddProductFlow()
        }
    }

    private var customTabBar: some View {
        ZStack {
            // Background
            Rectangle()
                .fill(.white)
                .frame(height: 68)
                .overlay(alignment: .top) {
                    Divider()
                }

            HStack {
                // Left tabs
                tabButton(.home)
                tabButton(.search)

                // Center FAB
                TabBarFAB {
                    showAddProduct = true
                }
                .offset(y: -14)

                // Right tabs
                tabButton(.chat)
                tabButton(.profile)
            }
            .padding(.horizontal, 8)
        }
    }

    private func tabButton(_ tab: TabItem) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 2) {
                Image(systemName: tab.icon)
                    .font(.system(size: 20))
                Text(tab.title)
                    .font(DinoFonts.small)
                if selectedTab == tab {
                    Circle()
                        .fill(DinoColors.yellow)
                        .frame(width: 4, height: 4)
                } else {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 4, height: 4)
                }
            }
            .foregroundStyle(selectedTab == tab ? DinoColors.darkText : DinoColors.mediumGray)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
