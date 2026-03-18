import Foundation

extension Int {
    var copFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "COP"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "es_CO")
        let formatted = formatter.string(from: NSNumber(value: self)) ?? "$\(self)"
        return "\(formatted) COP"
    }
}
