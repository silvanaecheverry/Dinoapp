import SwiftUI

struct SaleDetailScreen: View {
    @State private var viewModel: SaleDetailViewModel

    init(purchase: Purchase) {
        _viewModel = State(initialValue: SaleDetailViewModel(purchase: purchase))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 16) {
                    // Status pill (centered)
                    HStack(spacing: 6) {
                        Image(systemName: viewModel.statusIcon)
                            .font(.system(size: 12))
                        Text(viewModel.statusText)
                            .font(DinoFonts.callout)
                    }
                    .foregroundStyle(DinoColors.darkText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(hex: "F5F5F0"))
                    .clipShape(Capsule())

                    // MARK: - Product Info Card
                    if let product = viewModel.product {
                        HStack(spacing: 12) {
                            // 80pt image placeholder
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(DinoColors.lightGray)
                                    .frame(width: 80, height: 80)
                                Image(systemName: product.imageSystemName)
                                    .font(.system(size: 28))
                                    .foregroundStyle(DinoColors.mediumGray)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.title)
                                    .font(DinoFonts.subheadline)
                                    .foregroundStyle(DinoColors.darkText)
                                    .lineLimit(1)

                                HStack(spacing: 4) {
                                    Text(priceNumber(product.price))
                                        .font(DinoFonts.bold(18))
                                        .foregroundStyle(DinoColors.darkText)
                                    Text("COP")
                                        .font(DinoFonts.caption)
                                        .foregroundStyle(DinoColors.mediumGray)
                                }

                                Text("Listed by you")
                                    .font(DinoFonts.caption)
                                    .foregroundStyle(DinoColors.bodyText)
                            }

                            Spacer()
                        }
                        .padding(16)
                        .background(DinoColors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(DinoColors.cardBorder, lineWidth: 1)
                        )
                    }

                    // MARK: - Buyer Section
                    if let buyer = viewModel.buyer {
                        sectionHeader("Buyer")
                        BuyerInfoCard(buyer: buyer)
                    }

                    // MARK: - Delivery Details Section
                    sectionHeader("Delivery Details")
                    deliveryDetailsCard

                    // MARK: - Pickup Code Section
                    sectionHeader("Pickup Code")
                    PickupCodeCard(
                        digits: viewModel.lockerCodeDigits,
                        onCopy: { viewModel.copyCode() }
                    )

                    // MARK: - Next Steps Section
                    nextStepsCard
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 160)
            }

            // MARK: - Bottom Buttons (pinned)
            VStack(spacing: 8) {
                DinoButton(title: "Mark as Delivered to Locker", icon: "shippingbox.fill") {
                    viewModel.markAsDelivered()
                }

                DinoButton(title: "Chat with Buyer", icon: "message.fill", style: .outline) {
                    // Chat action
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .padding(.top, 12)
            .background(
                Color.white
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: -4)
            )
        }
        .background(Color.white)
        .navigationTitle("Sale Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sale Details")
                    .font(DinoFonts.semibold(20))
                    .foregroundStyle(DinoColors.darkText)
            }
        }
    }

    // MARK: - Section Header

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(DinoFonts.subheadline)
                .foregroundStyle(DinoColors.darkText)
            Spacer()
        }
    }

    // MARK: - Delivery Details Card

    private var deliveryDetailsCard: some View {
        VStack(spacing: 0) {
            // Location row
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(DinoColors.yellowLight)
                        .frame(width: 32, height: 32)
                    Image(systemName: "mappin")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "F4D03F"))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Location")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.bodyText)
                    Text(viewModel.lockerLocation)
                        .font(DinoFonts.subheadline)
                        .foregroundStyle(DinoColors.darkText)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider()
                .padding(.leading, 60)

            // Time row
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(DinoColors.yellowLight)
                        .frame(width: 32, height: 32)
                    Image(systemName: "clock")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "F4D03F"))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Meetup Time")
                        .font(DinoFonts.caption)
                        .foregroundStyle(DinoColors.bodyText)
                    Text(viewModel.meetupTime)
                        .font(DinoFonts.subheadline)
                        .foregroundStyle(DinoColors.darkText)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    // MARK: - Next Steps Card

    private var nextStepsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("NEXT STEPS")
                .font(DinoFonts.semibold(12))
                .tracking(0.5)
                .foregroundStyle(DinoColors.darkText)

            VStack(alignment: .leading, spacing: 10) {
                nextStepRow(number: 1, text: "Deliver the item to the agreed locker")
                nextStepRow(number: 2, text: "Mark as Delivered below")
                nextStepRow(number: 3, text: "Share the verification code when meeting")
                nextStepRow(number: 4, text: "Payment processed after buyer confirmation")
            }
        }
        .padding(16)
        .background(DinoColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(DinoColors.cardBorder, lineWidth: 1)
        )
    }

    private func nextStepRow(number: Int, text: String) -> some View {
        HStack(spacing: 10) {
            // Yellow circle with number
            ZStack {
                Circle()
                    .fill(DinoColors.yellow)
                    .frame(width: 16, height: 16)
                Text("\(number)")
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .foregroundStyle(DinoColors.darkText)
            }

            Text(text)
                .font(DinoFonts.caption)
                .foregroundStyle(DinoColors.bodyText)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Helpers

    private func priceNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.locale = Locale(identifier: "es_CO")
        return "$" + (formatter.string(from: NSNumber(value: price)) ?? "\(price)")
    }
}
