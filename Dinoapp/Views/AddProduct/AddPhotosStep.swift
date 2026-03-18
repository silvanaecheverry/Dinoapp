import SwiftUI
import PhotosUI

struct AddPhotosStep: View {
    @Bindable var viewModel: AddProductViewModel

    // 3 columns for the photo grid
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Photo Grid
                LazyVGrid(columns: columns, spacing: 12) {
                    // Existing photos
                    ForEach(Array(viewModel.loadedImages.enumerated()), id: \.offset) { index, image in
                        ZStack(alignment: .topTrailing) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 111, height: 111)
                                .clipShape(RoundedRectangle(cornerRadius: 12))

                            // "Cover" badge on first photo
                            if index == 0 {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("Cover")
                                            .font(DinoFonts.bold(10))
                                            .foregroundStyle(DinoColors.darkText)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(DinoColors.yellow)
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                            .padding(6)
                                        Spacer()
                                    }
                                }
                                .frame(width: 111, height: 111)
                            }

                            // X remove button - dark circle at top-right
                            Button {
                                viewModel.removeImage(at: index)
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.white)
                                    .frame(width: 22, height: 22)
                                    .background(DinoColors.darkBackground)
                                    .clipShape(Circle())
                            }
                            .offset(x: -6, y: 6)
                        }
                    }

                    // "Add Photo" tile (only show if < 5 photos)
                    if viewModel.loadedImages.count < 5 {
                        PhotosPicker(
                            selection: $viewModel.selectedPhotos,
                            maxSelectionCount: 5,
                            matching: .images
                        ) {
                            VStack(spacing: 8) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(DinoColors.darkText)
                                    .frame(width: 40, height: 40)
                                    .background(DinoColors.yellowLight)
                                    .clipShape(Circle())

                                Text("Add Photo")
                                    .font(DinoFonts.callout)
                                    .foregroundStyle(DinoColors.bodyText)
                            }
                            .frame(width: 111, height: 111)
                            .background(DinoColors.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(DinoColors.cardBorder, lineWidth: 1)
                            )
                        }
                        .onChange(of: viewModel.selectedPhotos) {
                            Task {
                                await viewModel.loadImages()
                            }
                        }
                    }
                }

                // MARK: - Tip Card
                HStack(alignment: .top, spacing: 12) {
                    // Camera/image icon in yellow-tinted 32pt rounded rect
                    Image(systemName: "camera.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(DinoColors.darkText)
                        .frame(width: 32, height: 32)
                        .background(DinoColors.yellowLight)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text("Good lighting helps sell faster. Include photos showing any wear or condition details.")
                        .font(DinoFonts.regular(14))
                        .foregroundStyle(DinoColors.bodyText)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DinoColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(DinoColors.cardBorder, lineWidth: 1)
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
    }
}

#Preview {
    AddPhotosStep(viewModel: AddProductViewModel())
}
