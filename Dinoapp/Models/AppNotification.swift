import Foundation

struct AppNotification: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var message: String
    var date: Date
    var isRead: Bool
    var iconName: String

    var timeAgo: String {
        let interval = Date().timeIntervalSince(date)
        let minutes = Int(interval / 60)
        if minutes < 60 { return "\(minutes)m ago" }
        let hours = minutes / 60
        if hours < 24 { return "\(hours)h ago" }
        let days = hours / 24
        return "\(days)d ago"
    }
}
