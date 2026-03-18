import SwiftUI

struct DinoButton: View {
    let title: String
    var icon: String? = nil
    var style: ButtonStyle = .primary
    let action: () -> Void

    enum ButtonStyle {
        case primary, secondary, outline
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(title)
                    .font(DinoFonts.semibold(16))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(borderColor, lineWidth: style == .outline ? 1 : 0)
            )
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: return DinoColors.darkText
        case .secondary: return .white
        case .outline: return DinoColors.darkText
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return DinoColors.yellow
        case .secondary: return DinoColors.darkText
        case .outline: return .clear
        }
    }

    private var borderColor: Color {
        switch style {
        case .outline: return DinoColors.cardBorder
        default: return .clear
        }
    }
}
