import SwiftUI

struct MyPurchasesScreen: View {
    @State private var viewModel = PurchasesViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Tab bar
            HStack(spacing: 0) {
                ForEach(PurchasesViewModel.PurchaseTab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Text(tab.rawValue)
                                .font(DinoFonts.subheadline)
                                .foregroundStyle(viewModel.selectedTab == tab ? DinoColors.darkText : DinoColors.mediumGray)

                            Rectangle()
                                .fill(viewModel.selectedTab == tab ? DinoColors.yellow : Color.clear)
                                .frame(height: 2)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 16)

            Divider()

            // Content
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.filteredPurchases) { purchase in
                        NavigationLink(value: purchase) {
                            PurchaseCard(
                                purchase: purchase,
                                product: viewModel.product(for: purchase),
                                seller: viewModel.seller(for: purchase)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 80)
            }
        }
        .background(Color.white)
        .navigationTitle("My Purchases")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("My Purchases")
                    .font(DinoFonts.semibold(20))
                    .foregroundStyle(DinoColors.darkText)
            }
        }
        .navigationDestination(for: Purchase.self) { purchase in
            SaleDetailScreen(purchase: purchase)
        }
    }
}
