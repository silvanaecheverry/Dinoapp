import SwiftUI

struct NotificationsScreen: View {
    @State private var viewModel = NotificationsViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.notifications.isEmpty {
                    emptyState
                } else {
                    notificationsList
                }
            }
            .navigationTitle("Notifications")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.markAllRead()
                    } label: {
                        Text("Mark all read")
                            .font(DinoFonts.callout)
                            .foregroundStyle(DinoColors.yellow)
                    }
                    .disabled(viewModel.unreadCount == 0)
                }
            }
        }
    }

    private var notificationsList: some View {
        List {
            ForEach(viewModel.notifications) { notification in
                NotificationRow(notification: notification)
                    .onTapGesture {
                        viewModel.markAsRead(id: notification.id)
                    }
                    .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "bell.slash")
                .font(.system(size: 48))
                .foregroundStyle(DinoColors.mediumGray)

            Text("No Notifications")
                .font(DinoFonts.title)
                .foregroundStyle(DinoColors.darkText)

            Text("You're all caught up!")
                .font(DinoFonts.body)
                .foregroundStyle(DinoColors.bodyText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NotificationsScreen()
}
