import SwiftUI

@Observable
class BuyFlowViewModel {
    var currentStep: Int = 1
    var selectedLocker: String? = nil
    var selectedTime: String? = nil
    var agreedToTerms: Bool = false

    var canContinue: Bool {
        selectedLocker != nil && selectedTime != nil
    }

    var canConfirm: Bool {
        agreedToTerms
    }

    let lockerOptions = [
        "Library - Locker A3",
        "SD Building - Locker B7",
        "W Building - Locker C2",
        "ML Building - Locker D5"
    ]

    let timeOptions = [
        "Today 2:00 PM",
        "Today 4:00 PM",
        "Today 6:00 PM",
        "Tomorrow 10:00 AM",
        "Tomorrow 2:00 PM",
        "Tomorrow 4:00 PM"
    ]
}

struct BuyFlowSheet: View {
    let product: Product
    var seller: User?
    @State private var viewModel = BuyFlowViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Close button and progress bar
            header

            if viewModel.currentStep == 1 {
                step1Content
            } else {
                step2Content
            }
        }
        .background(Color.white)
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 16) {
            // Close button
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 32, height: 32)
                        .background(DinoColors.cardBackground)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(DinoColors.cardBorder, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            // Progress bar
            HStack(spacing: 4) {
                Capsule()
                    .fill(DinoColors.yellow)
                    .frame(height: 2)
                Capsule()
                    .fill(viewModel.currentStep >= 2 ? DinoColors.yellow : DinoColors.lightGray)
                    .frame(height: 2)
            }
            .padding(.horizontal, 16)
        }
    }

    // MARK: - Step 1: Coordinate Pickup

    private var step1Content: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    VStack(spacing: 4) {
                        Text("Coordinate Pickup")
                            .font(DinoFonts.semibold(18))
                            .foregroundStyle(DinoColors.darkText)
                        Text("Choose where and when to meet the seller")
                            .font(DinoFonts.regular(14))
                            .foregroundStyle(DinoColors.mediumGray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)

                    // Product summary card
                    productSummaryCard

                    // Pickup location
                    pickupLocationSection

                    // Preferred time
                    preferredTimeSection

                    // Info tip
                    infoTipCard
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }

            // Bottom buttons
            step1BottomBar
        }
    }

    // MARK: - Step 2: Confirm Purchase

    private var step2Content: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    VStack(spacing: 4) {
                        Text("Confirm Purchase")
                            .font(DinoFonts.semibold(18))
                            .foregroundStyle(DinoColors.darkText)
                        Text("Review your purchase details before confirming")
                            .font(DinoFonts.regular(14))
                            .foregroundStyle(DinoColors.mediumGray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)

                    // Purchase summary
                    purchaseSummaryCard

                    // How payment works
                    paymentStepsCard

                    // Agreement checkbox
                    agreementSection
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }

            // Bottom buttons
            step2BottomBar
        }
    }

    // MARK: - Product Summary Card

    private var productSummaryCard: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(DinoColors.lightGray)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: product.imageSystemName)
                        .font(.system(size: 24))
                        .foregroundStyle(DinoColors.mediumGray)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(DinoFonts.semibold(14))
                    .foregroundStyle(DinoColors.darkText)
                    .lineLimit(1)

                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(product.priceFormatted.replacingOccurrences(of: " COP", with: ""))
                        .font(DinoFonts.bold(16))
                        .foregroundStyle(DinoColors.darkText)
                    Text(" COP")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }

                if let seller {
                    Text(seller.shortName)
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.mediumGray)
                }
            }

            Spacer()
        }
        .padding(12)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    // MARK: - Pickup Location Section

    private var pickupLocationSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 12))
                    .foregroundStyle(DinoColors.darkText)
                Text("PICKUP LOCATION")
                    .font(DinoFonts.semibold(12))
                    .foregroundStyle(DinoColors.darkText)
                    .tracking(0.5)
            }

            Menu {
                ForEach(viewModel.lockerOptions, id: \.self) { option in
                    Button(option) {
                        viewModel.selectedLocker = option
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.selectedLocker ?? "Select a campus locker")
                        .font(DinoFonts.regular(14))
                        .foregroundStyle(viewModel.selectedLocker != nil ? DinoColors.darkText : DinoColors.mediumGray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundStyle(DinoColors.mediumGray)
                }
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
            }
        }
    }

    // MARK: - Preferred Time Section

    private var preferredTimeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 12))
                    .foregroundStyle(DinoColors.darkText)
                Text("PREFERRED TIME")
                    .font(DinoFonts.semibold(12))
                    .foregroundStyle(DinoColors.darkText)
                    .tracking(0.5)
            }

            FlowLayout(spacing: 8) {
                ForEach(viewModel.timeOptions, id: \.self) { time in
                    timeChip(time)
                }
            }
        }
    }

    private func timeChip(_ time: String) -> some View {
        Button {
            viewModel.selectedTime = time
        } label: {
            Text(time)
                .font(DinoFonts.medium(12))
                .foregroundStyle(viewModel.selectedTime == time ? DinoColors.darkText : DinoColors.bodyText)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(viewModel.selectedTime == time ? DinoColors.yellow : DinoColors.cardBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(viewModel.selectedTime == time ? DinoColors.yellow : DinoColors.cardBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Info Tip Card

    private var infoTipCard: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "info.circle")
                .font(.system(size: 16))
                .foregroundStyle(DinoColors.yellow)

            Text("The seller will confirm your request. You'll be notified when they accept or suggest a different time.")
                .font(DinoFonts.regular(12))
                .foregroundStyle(DinoColors.bodyText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .background(DinoColors.yellow.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.yellow.opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: - Step 1 Bottom Bar

    private var step1BottomBar: some View {
        HStack(spacing: 12) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(DinoFonts.medium(14))
                    .foregroundStyle(DinoColors.darkText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(DinoColors.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(DinoColors.cardBorder, lineWidth: 1)
                    )
            }

            Button {
                withAnimation {
                    viewModel.currentStep = 2
                }
            } label: {
                Text("Continue")
                    .font(DinoFonts.semibold(14))
                    .foregroundStyle(DinoColors.darkText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(DinoColors.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .opacity(viewModel.canContinue ? 1.0 : 0.4)
            }
            .disabled(!viewModel.canContinue)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 24)
        .background(.white)
        .overlay(alignment: .top) {
            Divider()
        }
    }

    // MARK: - Purchase Summary Card

    private var purchaseSummaryCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PURCHASE SUMMARY")
                .font(DinoFonts.semibold(12))
                .foregroundStyle(DinoColors.darkText)
                .tracking(0.5)

            VStack(spacing: 10) {
                summaryRow(label: "Item", value: product.title)
                summaryRow(label: "Price", value: product.price.copFormatted)
                if let seller {
                    summaryRow(label: "Seller", value: seller.shortName)
                }
                summaryRow(label: "Location", value: viewModel.selectedLocker ?? "-")
                summaryRow(label: "Meetup", value: viewModel.selectedTime ?? "-")
            }
        }
        .padding(12)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    private func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(DinoFonts.caption)
                .foregroundStyle(DinoColors.mediumGray)
            Spacer()
            Text(value)
                .font(DinoFonts.semibold(12))
                .foregroundStyle(DinoColors.darkText)
                .lineLimit(1)
        }
    }

    // MARK: - Payment Steps Card

    private var paymentStepsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("HOW PAYMENT WORKS")
                .font(DinoFonts.semibold(12))
                .foregroundStyle(DinoColors.darkText)
                .tracking(0.5)

            VStack(alignment: .leading, spacing: 12) {
                paymentStep(number: 1, text: "Seller delivers item to agreed locker")
                paymentStep(number: 2, text: "You receive a 6-digit verification code")
                paymentStep(number: 3, text: "Inspect the item at the location")
                paymentStep(number: 4, text: "Enter the code to confirm & complete payment")
            }
        }
        .padding(12)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    private func paymentStep(number: Int, text: String) -> some View {
        HStack(spacing: 10) {
            Text("\(number)")
                .font(DinoFonts.bold(10))
                .foregroundStyle(DinoColors.darkText)
                .frame(width: 22, height: 22)
                .background(DinoColors.yellow)
                .clipShape(Circle())

            Text(text)
                .font(DinoFonts.regular(12))
                .foregroundStyle(DinoColors.bodyText)
        }
    }

    // MARK: - Agreement Section

    private var agreementSection: some View {
        Button {
            viewModel.agreedToTerms.toggle()
        } label: {
            HStack(alignment: .top, spacing: 10) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.agreedToTerms ? DinoColors.yellow : Color.clear)
                    .frame(width: 22, height: 22)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.agreedToTerms ? DinoColors.yellow : DinoColors.cardBorder, lineWidth: 1.5)
                    )
                    .overlay {
                        if viewModel.agreedToTerms {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(DinoColors.darkText)
                        }
                    }

                Text("I agree to meet at the specified location and time, inspect the item, and confirm payment only after verifying its condition.")
                    .font(DinoFonts.medium(12))
                    .foregroundStyle(DinoColors.bodyText)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Step 2 Bottom Bar

    private var step2BottomBar: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation {
                    viewModel.currentStep = 1
                }
            } label: {
                Text("Back")
                    .font(DinoFonts.medium(14))
                    .foregroundStyle(DinoColors.darkText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(DinoColors.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(DinoColors.cardBorder, lineWidth: 1)
                    )
            }

            Button {
                dismiss()
            } label: {
                Text("Confirm Purchase")
                    .font(DinoFonts.semibold(14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(viewModel.canConfirm ? DinoColors.darkBackground : DinoColors.darkBackground.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .disabled(!viewModel.canConfirm)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 24)
        .background(.white)
        .overlay(alignment: .top) {
            Divider()
        }
    }
}

#Preview {
    BuyFlowSheet(
        product: MockDataService.shared.products[0],
        seller: MockDataService.shared.users[0]
    )
}
