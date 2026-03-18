import SwiftUI

struct AddProductFlow: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = AddProductViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            VStack(spacing: 0) {
                // Top row: back button, title stack, user avatar
                HStack {
                    // Back button - 36pt circle, #FAFAF7 bg, #E5E7EB border, 16pt corner radius
                    Button {
                        if viewModel.currentStep > 1 {
                            viewModel.previousStep()
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(DinoColors.darkText)
                            .frame(width: 36, height: 36)
                            .background(DinoColors.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(DinoColors.cardBorder, lineWidth: 1)
                            )
                    }

                    Spacer()

                    // Center title + subtitle
                    VStack(spacing: 2) {
                        Text(viewModel.stepTitle)
                            .font(DinoFonts.semibold(16))
                            .foregroundStyle(DinoColors.darkText)

                        Text(viewModel.stepSubtitle)
                            .font(DinoFonts.regular(12))
                            .foregroundStyle(DinoColors.bodyText)
                    }

                    Spacer()

                    // User avatar - yellow 28pt rounded rect with "U" initial
                    Text("U")
                        .font(DinoFonts.bold(12))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 28, height: 28)
                        .background(DinoColors.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 12)

                // Progress bar
                DinoProgressBar(currentStep: viewModel.currentStep, totalSteps: 3)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                // Description text
                Text(viewModel.stepDescription)
                    .font(DinoFonts.regular(14))
                    .foregroundStyle(DinoColors.bodyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                // Bottom border
                Divider()
            }

            // MARK: - Content
            Group {
                switch viewModel.currentStep {
                case 1:
                    AddPhotosStep(viewModel: viewModel)
                case 2:
                    ItemDetailsStep(viewModel: viewModel)
                case 3:
                    ReviewPublishStep(viewModel: viewModel)
                default:
                    EmptyView()
                }
            }
            .frame(maxHeight: .infinity)

            // MARK: - Bottom Button
            VStack(spacing: 0) {
                Divider()

                Group {
                    if viewModel.currentStep == 3 {
                        // Publish button: dark when incomplete, yellow when all complete
                        Button {
                            if viewModel.allChecklistComplete {
                                viewModel.publish()
                                dismiss()
                            }
                        } label: {
                            Text("Publish Listing")
                                .font(DinoFonts.semibold(16))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundStyle(
                                    viewModel.allChecklistComplete
                                        ? DinoColors.darkText
                                        : .white
                                )
                                .background(
                                    viewModel.allChecklistComplete
                                        ? DinoColors.yellow
                                        : DinoColors.darkBackground
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .opacity(viewModel.allChecklistComplete ? 1.0 : 0.5)
                        }
                        .disabled(!viewModel.allChecklistComplete)
                    } else {
                        // Continue button - yellow, full-width, 50pt height, 24pt radius
                        Button {
                            viewModel.nextStep()
                        } label: {
                            Text("Continue")
                                .font(DinoFonts.semibold(16))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundStyle(DinoColors.darkText)
                                .background(DinoColors.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                        .opacity(viewModel.canProceed ? 1.0 : 0.5)
                        .disabled(!viewModel.canProceed)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
        }
        .background(Color.white)
    }
}

#Preview {
    AddProductFlow()
}
