import SwiftUI

struct CategoryFilterChips: View {
    @Binding var selectedCategory: Category?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                DinoChip(
                    title: "All",
                    isSelected: selectedCategory == nil,
                    action: { selectedCategory = nil }
                )

                ForEach(Category.allCases) { category in
                    DinoChip(
                        title: category.rawValue,
                        isSelected: selectedCategory == category,
                        action: { selectedCategory = category }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    CategoryFilterChips(selectedCategory: .constant(nil))
}
