import SwiftUI

struct ItemDetailsStep: View {
    @Bindable var viewModel: AddProductViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Title
                VStack(alignment: .leading, spacing: 6) {
                    Text("TITLE")
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.bodyText)

                    TextField("e.g., TI-84 Calculator", text: $viewModel.title)
                        .font(DinoFonts.body)
                        .foregroundStyle(DinoColors.darkText)
                        .padding(12)
                        .background(DinoColors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(DinoColors.cardBorder, lineWidth: 1)
                        )
                }

                // MARK: - Description
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("DESCRIPTION")
                            .font(DinoFonts.callout)
                            .foregroundStyle(DinoColors.bodyText)

                        Spacer()

                        // "AI Generate" button
                        Button {
                            // AI generate action placeholder
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 12, weight: .semibold))
                                Text("AI Generate")
                                    .font(DinoFonts.callout)
                            }
                            .foregroundStyle(DinoColors.darkText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(DinoColors.yellowLight)
                            .clipShape(Capsule())
                        }
                    }

                    TextField("Describe your item...", text: $viewModel.description, axis: .vertical)
                        .font(DinoFonts.body)
                        .foregroundStyle(DinoColors.darkText)
                        .lineLimit(4...6)
                        .padding(12)
                        .frame(minHeight: 106, alignment: .top)
                        .background(DinoColors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(DinoColors.cardBorder, lineWidth: 1)
                        )
                }

                // MARK: - Category (dropdown selector)
                VStack(alignment: .leading, spacing: 6) {
                    Text("CATEGORY")
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.bodyText)

                    Menu {
                        ForEach(Category.allCases) { category in
                            Button {
                                viewModel.selectedCategory = category
                                viewModel.categoryConfirmed = true
                            } label: {
                                Text(category.rawValue)
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.categoryConfirmed ? viewModel.selectedCategory.rawValue : "Select category")
                                .font(DinoFonts.body)
                                .foregroundStyle(
                                    viewModel.categoryConfirmed
                                        ? DinoColors.darkText
                                        : DinoColors.mediumGray
                                )

                            Spacer()

                            Image(systemName: "chevron.down")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(DinoColors.mediumGray)
                        }
                        .padding(12)
                        .background(DinoColors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(DinoColors.cardBorder, lineWidth: 1)
                        )
                    }
                }

                // MARK: - Condition (3 equal-width buttons)
                VStack(alignment: .leading, spacing: 6) {
                    Text("CONDITION")
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.bodyText)

                    HStack(spacing: 8) {
                        ConditionButton(
                            label: "Like New",
                            isSelected: viewModel.selectedCondition == .likeNew
                        ) {
                            viewModel.selectedCondition = .likeNew
                        }

                        ConditionButton(
                            label: "Good",
                            isSelected: viewModel.selectedCondition == .good
                        ) {
                            viewModel.selectedCondition = .good
                        }

                        ConditionButton(
                            label: "Fair",
                            isSelected: viewModel.selectedCondition == .fair
                        ) {
                            viewModel.selectedCondition = .fair
                        }
                    }
                }

                // MARK: - Price (COP)
                VStack(alignment: .leading, spacing: 6) {
                    Text("PRICE (COP)")
                        .font(DinoFonts.callout)
                        .foregroundStyle(DinoColors.bodyText)

                    HStack(spacing: 0) {
                        Text("$")
                            .font(DinoFonts.body)
                            .foregroundStyle(DinoColors.mediumGray)
                            .padding(.leading, 12)

                        TextField("0", text: $viewModel.priceText)
                            .font(DinoFonts.body)
                            .foregroundStyle(DinoColors.darkText)
                            .keyboardType(.numberPad)
                            .padding(.leading, 4)
                            .padding(.vertical, 12)
                            .padding(.trailing, 12)
                    }
                    .background(DinoColors.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(DinoColors.cardBorder, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
    }
}

// MARK: - Condition Button

private struct ConditionButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(DinoFonts.callout)
                .foregroundStyle(isSelected ? DinoColors.darkText : DinoColors.bodyText)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(isSelected ? DinoColors.yellow : DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isSelected ? Color.clear : DinoColors.cardBorder,
                            lineWidth: 1
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ItemDetailsStep(viewModel: AddProductViewModel())
}
