import SwiftUI

enum DinoFonts {
    static func bold(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }

    static func semibold(_ size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }

    static func medium(_ size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .rounded)
    }

    static func regular(_ size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }

    // Predefined sizes
    static let largeTitle = semibold(28)
    static let title = semibold(20)
    static let headline = semibold(16)
    static let subheadline = semibold(14)
    static let body = regular(14)
    static let callout = medium(12)
    static let caption = regular(12)
    static let small = regular(11)
    static let micro = bold(10)
}
