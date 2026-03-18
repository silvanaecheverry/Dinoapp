import SwiftUI

enum AppScreen {
    case splash
    case login
    case profileSetup
    case main
}

@Observable
class AppState {
    var currentScreen: AppScreen = .splash
    var currentUser: User?
    var isLoggedIn: Bool = false

    func completeOnboarding() {
        currentScreen = .main
        isLoggedIn = true
    }

    func login() {
        currentScreen = .profileSetup
    }

    func completeProfileSetup(name: String, major: String, courses: [String]) {
        currentUser = User(
            id: UUID(),
            name: name,
            email: "\(name.lowercased().replacingOccurrences(of: " ", with: "."))@uniandes.edu.co",
            major: major,
            courses: courses,
            avatarInitial: String(name.prefix(1)).uppercased(),
            rating: 5.0,
            activeListings: 0,
            completedSales: 0
        )
        completeOnboarding()
    }
}
