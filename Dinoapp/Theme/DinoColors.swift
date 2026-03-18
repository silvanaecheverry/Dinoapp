import SwiftUI

enum DinoColors {
    static let yellow = Color(hex: "FCD34D")
    static let darkText = Color(hex: "1F2937")
    static let lightGray = Color(hex: "F3F4F6")
    static let mediumGray = Color(hex: "9CA3AF")
    static let green = Color(hex: "10B981")
    static let blue = Color(hex: "3B82F6")
    static let red = Color(hex: "EF4444")
    static let cardBorder = Color(hex: "E5E7EB")
    static let bodyText = Color(hex: "6B7280")
    static let darkBackground = Color(hex: "1A1A1A")
    static let cardBackground = Color(hex: "FAFAF7")
    static let yellowLight = Color(hex: "FCD34D").opacity(0.15)
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
