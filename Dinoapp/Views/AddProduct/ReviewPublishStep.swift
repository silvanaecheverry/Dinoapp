import SwiftUI

struct ReviewPublishStep: View {
    var viewModel: AddProductViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Preview Card
                VStack(spacing: 0) {
                    // Image area - 180pt height
                    if let firstImage = viewModel.loadedImages.first {
                        firstImage
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 16
                                )
                            )
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(DinoColors.lightGray)
                                .frame(height: 180)
                                .clipShape(
                                    UnevenRoundedRectangle(
                                        topLeadingRadius: 16,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 16
                                    )
                                )

                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundStyle(DinoColors.mediumGray)
                        }
                    }

                    // Title and price
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.title.isEmpty ? "Untitled" : viewModel.title)
                            .font(DinoFonts.semibold(18))
                            .foregroundStyle(DinoColors.darkText)

                        // Price: $0 COP format - large price + small COP
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(viewModel.price > 0 ? "$\(viewModel.price)" : "$0")
                                .font(DinoFonts.semibold(18))
                                .foregroundStyle(DinoColors.darkText)

                            Text("COP")
                                .font(DinoFonts.regular(12))
                                .foregroundStyle(DinoColors.bodyText)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )

                // MARK: - Checklist (5 items)
                VStack(alignment: .leading, spacing: 12) {
                    ChecklistRow(
                        title: "Photos added",
                        isComplete: viewModel.hasPhotos
                    )

                    ChecklistRow(
                        title: "Title set",
                        isComplete: viewModel.hasTitle
                    )

                    ChecklistRow(
                        title: "Price set",
                        isComplete: viewModel.hasPrice
                    )

                    ChecklistRow(
                        title: "Category selected",
                        isComplete: viewModel.hasCategory
                    )

                    ChecklistRow(
                        title: "Condition noted",
                        isComplete: viewModel.hasCondition
                    )
                }
                .padding(.horizontal, 4)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
    }
}

// MARK: - Checklist Row

private struct ChecklistRow: View {
    let title: String
    let isComplete: Bool

    var body: some View {
        HStack(spacing: 10) {
            // 20pt circle: green #10B981 if complete, gray #E5E7EB if not
            ZStack {
                Circle()
                    .fill(isComplete ? DinoColors.green : DinoColors.cardBorder)
                    .frame(width: 20, height: 20)

                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
            }

            Text(title)
                .font(DinoFonts.regular(14))
                .foregroundStyle(isComplete ? DinoColors.darkText : DinoColors.bodyText)

            Spacer()
        }
    }
}

#Preview {
    ReviewPublishStep(viewModel: AddProductViewModel())
}
