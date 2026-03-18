import SwiftUI

@Observable
class OnboardingViewModel {
    var name: String = ""
    var selectedMajor: String? = nil
    var selectedCourses: Set<String> = []

    let availableMajors: [String] = [
        "Systems Engineering",
        "Industrial Engineering",
        "Economics",
        "Architecture",
        "Law",
        "Medicine",
        "Music",
        "Computer Science",
        "Mechanical Engineering",
        "Civil Engineering",
        "Business Administration"
    ]

    let availableCourses: [String] = [
        "Algorithms",
        "Data Structures",
        "Calculus",
        "Linear Algebra",
        "Physics",
        "Chemistry",
        "Statistics",
        "Marketing",
        "Finance",
        "Microeconomics"
    ]

    var isProfileValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && selectedMajor != nil
    }

    func toggleCourse(_ course: String) {
        if selectedCourses.contains(course) {
            selectedCourses.remove(course)
        } else {
            selectedCourses.insert(course)
        }
    }

    var courses: [String] {
        Array(selectedCourses).sorted()
    }
}
