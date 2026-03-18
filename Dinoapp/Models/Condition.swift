import Foundation

enum Condition: String, CaseIterable, Identifiable, Hashable, Codable {
    case new = "New"
    case likeNew = "Like New"
    case good = "Good"
    case fair = "Fair"

    var id: String { rawValue }
}
