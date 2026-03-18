import SwiftUI

struct SettingsNavigationRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(DinoColors.yellow)
                .frame(width: 24)

            Text(title)
                .font(DinoFonts.body)
                .foregroundStyle(DinoColors.darkText)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(DinoColors.mediumGray)
        }
    }
}

#Preview {
    Form {
        SettingsNavigationRow(icon: "person.fill", title: "Edit Profile")
    }
}
