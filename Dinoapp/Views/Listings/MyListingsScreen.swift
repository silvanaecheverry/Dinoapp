import SwiftUI

struct MyListingsScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: ListingsViewModel?

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(resolvedViewModel.listings) { product in
                    ListingCard(product: product)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 80)
        }
        .background(Color.white)
        .navigationTitle("My Listings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("My Listings")
                    .font(DinoFonts.semibold(20))
                    .foregroundStyle(DinoColors.darkText)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // New listing action
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .bold))
                        Text("New")
                            .font(DinoFonts.semibold(13))
                    }
                    .foregroundStyle(DinoColors.darkText)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(DinoColors.yellow)
                    .clipShape(Capsule())
                }
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = ListingsViewModel(appState: appState)
            }
        }
    }

    private var resolvedViewModel: ListingsViewModel {
        viewModel ?? ListingsViewModel(appState: appState)
    }
}
