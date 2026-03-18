import Foundation

@Observable
class SettingsViewModel {
    var pushNotifications: Bool = true
    var emailNotifications: Bool = true
    var darkMode: Bool = false
    var locationServices: Bool = true
}
