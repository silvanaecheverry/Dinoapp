import SwiftUI

struct NotificationRow: View {
    let notification: AppNotification

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon in yellow circle
            ZStack {
                Circle()
                    .fill(DinoColors.yellow.opacity(0.15))
                    .frame(width: 40, height: 40)

                Image(systemName: notification.iconName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(DinoColors.yellow)
            }

            // Title and message
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title)
                    .font(notification.isRead ? DinoFonts.body : DinoFonts.semibold(14))
                    .foregroundStyle(DinoColors.darkText)

                Text(notification.message)
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.bodyText)
                    .lineLimit(2)
            }

            Spacer()

            // Time ago and unread dot
            VStack(alignment: .trailing, spacing: 6) {
                Text(notification.timeAgo)
                    .font(DinoFonts.small)
                    .foregroundStyle(DinoColors.mediumGray)

                if !notification.isRead {
                    Circle()
                        .fill(DinoColors.yellow)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    NotificationRow(
        notification: AppNotification(
            id: UUID(),
            title: "Item Sold!",
            message: "Your TI-84 Calculator has been purchased by Ana G.",
            date: Date().addingTimeInterval(-3600),
            isRead: false,
            iconName: "tag.fill"
        )
    )
    .padding()
}
