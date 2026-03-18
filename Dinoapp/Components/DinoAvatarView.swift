import SwiftUI

struct DinoAvatarView: View {
    let initial: String
    var size: CGFloat = 16

    var body: some View {
        ZStack {
            Circle()
                .fill(DinoColors.darkBackground)
                .frame(width: size, height: size)
            Text(initial)
                .font(.system(size: size * 0.5, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}
