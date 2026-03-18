import Foundation

@Observable
class NotificationsViewModel {
    private let dataService = MockDataService.shared

    var notifications: [AppNotification]

    init() {
        notifications = dataService.notifications
    }

    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }

    func markAsRead(id: UUID) {
        if let index = notifications.firstIndex(where: { $0.id == id }) {
            notifications[index].isRead = true
        }
    }

    func markAllRead() {
        for index in notifications.indices {
            notifications[index].isRead = true
        }
    }
}
