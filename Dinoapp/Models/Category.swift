import Foundation

enum Category: String, CaseIterable, Identifiable, Hashable, Codable {
    case textbooks = "Textbooks"
    case calculators = "Calculators"
    case furniture = "Furniture"
    case tech = "Tech"
    case supplies = "Supplies"
    case clothing = "Clothing"
    case other = "Other"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .textbooks: return "book.fill"
        case .calculators: return "plus.forwardslash.minus"
        case .furniture: return "chair.lounge.fill"
        case .tech: return "laptopcomputer"
        case .supplies: return "pencil.and.ruler.fill"
        case .clothing: return "tshirt.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }
}
