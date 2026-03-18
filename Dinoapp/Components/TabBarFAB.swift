import SwiftUI

struct TabBarFAB: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(DinoColors.darkText)
                .frame(width: 56, height: 56)
                .background(DinoColors.yellow)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
        }
    }
}
