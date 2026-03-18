import SwiftUI

struct DinoProgressBar: View {
    let currentStep: Int
    let totalSteps: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...totalSteps, id: \.self) { step in
                RoundedRectangle(cornerRadius: 4)
                    .fill(barColor(for: step))
                    .frame(height: 4)
            }
        }
    }

    /// Progress bar coloring per Figma:
    /// Step 1: bar1=yellow, bar2=gray, bar3=gray
    /// Step 2: bar1=dark, bar2=yellow, bar3=gray
    /// Step 3: bar1=dark, bar2=dark, bar3=yellow
    private func barColor(for bar: Int) -> Color {
        if bar == currentStep {
            return DinoColors.yellow
        } else if bar < currentStep {
            return DinoColors.darkBackground
        } else {
            return DinoColors.cardBorder
        }
    }
}
