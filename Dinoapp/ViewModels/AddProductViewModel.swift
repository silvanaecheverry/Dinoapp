import SwiftUI
import PhotosUI

@Observable
class AddProductViewModel {
    var currentStep: Int = 1

    // MARK: - Step 1: Photos
    var selectedPhotos: [PhotosPickerItem] = []
    var loadedImages: [Image] = []

    // MARK: - Step 2: Details
    var title: String = ""
    var description: String = ""
    var selectedCategory: Category = .textbooks
    var selectedCondition: Condition = .likeNew
    var priceText: String = ""
    var showCategoryPicker: Bool = false
    var categoryConfirmed: Bool = false

    // MARK: - Computed

    var price: Int {
        Int(priceText) ?? 0
    }

    var canProceed: Bool {
        switch currentStep {
        case 1:
            return !loadedImages.isEmpty
        case 2:
            return !title.trimmingCharacters(in: .whitespaces).isEmpty
                && !description.trimmingCharacters(in: .whitespaces).isEmpty
                && price > 0
        case 3:
            return allChecklistComplete
        default:
            return false
        }
    }

    var stepTitle: String {
        switch currentStep {
        case 1: return "Add Photos"
        case 2: return "Item Details"
        case 3: return "Review & Publish"
        default: return ""
        }
    }

    var stepSubtitle: String {
        return "Step \(currentStep) of 3"
    }

    var stepDescription: String {
        switch currentStep {
        case 1: return "Add up to 5 photos. First photo will be the cover."
        case 2: return "Provide accurate information about your item."
        case 3: return "Make sure everything looks good before publishing."
        default: return ""
        }
    }

    // MARK: - Checklist (5 items)

    var hasPhotos: Bool { !loadedImages.isEmpty }
    var hasTitle: Bool { !title.trimmingCharacters(in: .whitespaces).isEmpty }
    var hasPrice: Bool { price > 0 }
    var hasCategory: Bool { categoryConfirmed }
    var hasCondition: Bool { true } // Condition always has a default

    var allChecklistComplete: Bool {
        hasPhotos && hasTitle && hasPrice && hasCategory && hasCondition
    }

    // MARK: - Actions

    func nextStep() {
        if currentStep < 3 {
            currentStep += 1
        }
    }

    func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }

    func loadImages() async {
        var images: [Image] = []
        for item in selectedPhotos.prefix(5) {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                images.append(Image(uiImage: uiImage))
            }
        }
        await MainActor.run {
            loadedImages = images
        }
    }

    func removeImage(at index: Int) {
        guard index < loadedImages.count else { return }
        loadedImages.remove(at: index)
        if index < selectedPhotos.count {
            selectedPhotos.remove(at: index)
        }
    }

    func publish() {
        print("Published!")
    }
}
