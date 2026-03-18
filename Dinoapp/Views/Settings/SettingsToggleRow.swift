import SwiftUI

struct SettingsToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(DinoColors.yellow)
                    .frame(width: 24)

                Text(title)
                    .font(DinoFonts.body)
                    .foregroundStyle(DinoColors.darkText)
            }
        }
        .tint(DinoColors.yellow)
    }
}

#Preview {
    Form {
        SettingsToggleRow(
            icon: "bell.fill",
            title: "Push Notifications",
            isOn: .constant(true)
        )
    }
}
