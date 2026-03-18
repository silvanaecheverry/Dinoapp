import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var email: String
    var major: String
    var courses: [String]
    var avatarInitial: String
    var rating: Double
    var activeListings: Int
    var completedSales: Int

    var firstName: String {
        let components = name.components(separatedBy: " ")
        return components.first ?? name
    }

    var shortName: String {
        let components = name.components(separatedBy: " ")
        if let first = components.first, let last = components.last?.prefix(1) {
            return "\(first) \(last)."
        }
        return name
    }
}
