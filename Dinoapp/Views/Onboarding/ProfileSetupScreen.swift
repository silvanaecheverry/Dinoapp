import SwiftUI

struct ProfileSetupScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = OnboardingViewModel()
    // Figma specifies #F4D03F for progress segments
    private let progressYellow = Color(hex: "F4D03F")
    private let progressGray = Color(hex: "E5E7EB")
    private let labelColor = Color(hex: "374151")

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            headerSection

            Divider()

            // MARK: - Scrollable Form
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    nameField
                    majorField
                    coursesField
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }

            // MARK: - Bottom Pinned Area
            bottomSection
        }
        .background(.white)
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Mini logo: yellow "U" rounded rect + "Dino"
            HStack(spacing: 6) {
                Text("U")
                    .font(DinoFonts.bold(16))
                    .foregroundStyle(DinoColors.darkText)
                    .frame(width: 32, height: 32)
                    .background(DinoColors.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text("Dino")
                    .font(DinoFonts.bold(18))
                    .foregroundStyle(DinoColors.darkText)
            }

            // Title
            Text("Complete your\nprofile")
                .font(DinoFonts.semibold(24))
                .foregroundStyle(DinoColors.darkText)
                .lineSpacing(2)

            // Subtitle
            Text("Help us personalize your experience")
                .font(DinoFonts.regular(14))
                .foregroundStyle(DinoColors.mediumGray)

            // Progress bar: 3 segments
            progressBar
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }

    private var progressBar: some View {
        HStack(spacing: 6) {
            // Segment 1 - filled
            Capsule()
                .fill(progressYellow)
                .frame(height: 4)

            // Segment 2 - filled
            Capsule()
                .fill(progressYellow)
                .frame(height: 4)

            // Segment 3 - gray
            Capsule()
                .fill(progressGray)
                .frame(height: 4)
        }
    }

    // MARK: - Name Field

    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            fieldLabel("YOUR NAME")

            TextField("e.g., Martina López", text: $viewModel.name)
                .font(DinoFonts.regular(14))
                .foregroundStyle(DinoColors.darkText)
                .frame(height: 48)
                .padding(.horizontal, 14)
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
        }
    }

    // MARK: - Major Field

    private var majorField: some View {
        VStack(alignment: .leading, spacing: 8) {
            fieldLabel("WHAT'S YOUR MAJOR?")

            Menu {
                ForEach(viewModel.availableMajors, id: \.self) { major in
                    Button(major) {
                        viewModel.selectedMajor = major
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.selectedMajor ?? "Select your major")
                        .font(DinoFonts.regular(14))
                        .foregroundStyle(
                            viewModel.selectedMajor != nil
                                ? DinoColors.darkText
                                : DinoColors.mediumGray
                        )

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(DinoColors.mediumGray)
                }
                .frame(height: 48)
                .padding(.horizontal, 14)
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
            }
        }
    }

    // MARK: - Courses Field

    private var coursesField: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Label with "(optional)" in regular gray
            HStack(spacing: 4) {
                Text("YOUR COURSES")
                    .font(DinoFonts.semibold(12))
                    .tracking(0.5)
                    .foregroundStyle(labelColor)

                Text("(optional)")
                    .font(DinoFonts.regular(12))
                    .foregroundStyle(DinoColors.mediumGray)
            }

            // Flowing chip layout
            FlowLayout(spacing: 8) {
                ForEach(viewModel.availableCourses, id: \.self) { course in
                    courseChip(course)
                }
            }
        }
    }

    private func courseChip(_ course: String) -> some View {
        let isSelected = viewModel.selectedCourses.contains(course)

        return Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                viewModel.toggleCourse(course)
            }
        } label: {
            Text(course)
                .font(DinoFonts.medium(12))
                .foregroundStyle(DinoColors.darkText)
                .padding(.horizontal, 14)
                .frame(height: 30)
                .background(isSelected ? progressYellow : DinoColors.cardBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : DinoColors.cardBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Bottom Section

    private var bottomSection: some View {
        VStack(spacing: 12) {
            Divider()

            VStack(spacing: 10) {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        appState.completeProfileSetup(
                            name: viewModel.name,
                            major: viewModel.selectedMajor ?? "",
                            courses: viewModel.courses
                        )
                    }
                } label: {
                    Text("Complete Setup")
                        .font(DinoFonts.semibold(16))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(DinoColors.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .disabled(!viewModel.isProfileValid)
                .opacity(viewModel.isProfileValid ? 1 : 0.5)

                Text("You can update your profile anytime in settings")
                    .font(DinoFonts.caption)
                    .foregroundStyle(DinoColors.mediumGray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
    }

    // MARK: - Helpers

    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(DinoFonts.semibold(12))
            .tracking(0.5)
            .foregroundStyle(labelColor)
    }
}

// MARK: - FlowLayout

/// A layout that arranges its children in horizontal rows,
/// wrapping to the next line when there is not enough space.
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = computeLayout(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = computeLayout(proposal: proposal, subviews: subviews)

        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: .unspecified
            )
        }
    }

    private struct LayoutResult {
        var positions: [CGPoint]
        var size: CGSize
    }

    private func computeLayout(proposal: ProposedViewSize, subviews: Subviews) -> LayoutResult {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        var totalWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX + size.width > maxWidth, currentX > 0 {
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }

            positions.append(CGPoint(x: currentX, y: currentY))
            rowHeight = max(rowHeight, size.height)
            currentX += size.width + spacing
            totalWidth = max(totalWidth, currentX - spacing)
        }

        let totalHeight = currentY + rowHeight
        return LayoutResult(
            positions: positions,
            size: CGSize(width: totalWidth, height: totalHeight)
        )
    }
}

#Preview {
    ProfileSetupScreen()
        .environment(AppState())
}
