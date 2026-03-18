import Foundation

class MockDataService {
    static let shared = MockDataService()
    private init() {}

    // MARK: - Users
    lazy var users: [User] = [
        User(id: userIDs[0], name: "Carlos Martinez", email: "c.martinez@uniandes.edu.co", major: "Systems Engineering", courses: ["Algorithms", "Databases"], avatarInitial: "C", rating: 4.8, activeListings: 3, completedSales: 12),
        User(id: userIDs[1], name: "Ana Garcia", email: "a.garcia@uniandes.edu.co", major: "Economics", courses: ["Calculus III", "Microeconomics"], avatarInitial: "A", rating: 5.0, activeListings: 1, completedSales: 8),
        User(id: userIDs[2], name: "Pedro Lopez", email: "p.lopez@uniandes.edu.co", major: "Industrial Engineering", courses: ["Physics II", "Statistics"], avatarInitial: "P", rating: 4.9, activeListings: 2, completedSales: 15),
        User(id: userIDs[3], name: "Sofia Rodriguez", email: "s.rodriguez@uniandes.edu.co", major: "Architecture", courses: ["Design Studio", "Art History"], avatarInitial: "S", rating: 4.7, activeListings: 1, completedSales: 5),
        User(id: userIDs[4], name: "Miguel Alvarez", email: "m.alvarez@uniandes.edu.co", major: "Music", courses: ["Music Theory", "Audio Engineering"], avatarInitial: "M", rating: 4.9, activeListings: 2, completedSales: 10),
        User(id: userIDs[5], name: "Laura Vargas", email: "l.vargas@uniandes.edu.co", major: "Law", courses: ["Constitutional Law", "Ethics"], avatarInitial: "L", rating: 4.8, activeListings: 1, completedSales: 7),
        User(id: userIDs[6], name: "Martina Rivera", email: "m.rivera@uniandes.edu.co", major: "Systems Engineering", courses: ["Algorithms", "Data Structures"], avatarInitial: "MR", rating: 4.9, activeListings: 0, completedSales: 3),
    ]

    private let userIDs = (0..<7).map { _ in UUID() }

    // MARK: - Products
    lazy var products: [Product] = [
        Product(id: UUID(), title: "TI-84 Calculator", description: "TI-84 Plus CE graphing calculator in excellent condition. Used for one semester.", price: 250_000, category: .calculators, condition: .likeNew, status: .active, sellerID: userIDs[0], isFeatured: true, imageSystemName: "plus.forwardslash.minus", postedDate: Date().addingTimeInterval(-86400 * 2), viewsCount: 42),
        Product(id: UUID(), title: "Calculus Textbook", description: "Stewart Calculus 8th Edition. Some highlighting but overall good condition.", price: 120_000, category: .textbooks, condition: .good, status: .reserved, sellerID: userIDs[0], isFeatured: false, imageSystemName: "book.fill", postedDate: Date().addingTimeInterval(-86400 * 3), viewsCount: 28),
        Product(id: UUID(), title: "MacBook Air M1", description: "2020 MacBook Air M1, 8GB RAM, 256GB SSD. Perfect for engineering students.", price: 3_500_000, category: .tech, condition: .likeNew, status: .active, sellerID: userIDs[2], isFeatured: true, imageSystemName: "laptopcomputer", postedDate: Date().addingTimeInterval(-86400), viewsCount: 156),
        Product(id: UUID(), title: "Desk Lamp", description: "LED desk lamp with adjustable brightness. Great for late-night studying.", price: 80_000, category: .furniture, condition: .good, status: .active, sellerID: userIDs[3], isFeatured: false, imageSystemName: "lamp.desk.fill", postedDate: Date().addingTimeInterval(-86400 * 5), viewsCount: 15),
        Product(id: UUID(), title: "Sony Headphones", description: "Sony WH-1000XM4 noise cancelling headphones. Battery life still excellent.", price: 350_000, category: .tech, condition: .likeNew, status: .sold, sellerID: userIDs[0], isFeatured: false, imageSystemName: "headphones", postedDate: Date().addingTimeInterval(-86400 * 4), viewsCount: 89),
        Product(id: UUID(), title: "Student Backpack", description: "Herschel backpack with laptop compartment. Barely used.", price: 150_000, category: .clothing, condition: .likeNew, status: .active, sellerID: userIDs[5], isFeatured: false, imageSystemName: "backpack.fill", postedDate: Date().addingTimeInterval(-86400 * 6), viewsCount: 33),
        Product(id: UUID(), title: "Physics Lab Manual", description: "Physics II lab manual. Required for FISI 1018.", price: 45_000, category: .textbooks, condition: .fair, status: .active, sellerID: userIDs[2], isFeatured: false, imageSystemName: "book.closed.fill", postedDate: Date().addingTimeInterval(-86400 * 7), viewsCount: 12),
        Product(id: UUID(), title: "Scientific Calculator", description: "Casio fx-991LA X ClassWiz. Perfect for exams.", price: 95_000, category: .calculators, condition: .new, status: .active, sellerID: userIDs[4], isFeatured: false, imageSystemName: "number", postedDate: Date().addingTimeInterval(-86400 * 1), viewsCount: 51),
        Product(id: UUID(), title: "Organic Chemistry Notes", description: "Complete semester notes for QUIM 1301. Hand-written, very detailed.", price: 35_000, category: .textbooks, condition: .good, status: .expired, sellerID: userIDs[0], isFeatured: false, imageSystemName: "doc.text.fill", postedDate: Date().addingTimeInterval(-86400 * 30), viewsCount: 8),
        Product(id: UUID(), title: "Ergonomic Chair", description: "Office chair with lumbar support. Height adjustable.", price: 280_000, category: .furniture, condition: .good, status: .active, sellerID: userIDs[0], isFeatured: false, imageSystemName: "chair.lounge.fill", postedDate: Date().addingTimeInterval(-86400 * 1), viewsCount: 67),
    ]

    var featuredProducts: [Product] {
        products.filter { $0.isFeatured }
    }

    var trendingProducts: [Product] {
        Array(products.prefix(4))
    }

    func seller(for product: Product) -> User? {
        users.first { $0.id == product.sellerID }
    }

    // MARK: - Purchases
    lazy var purchases: [Purchase] = [
        Purchase(id: UUID(), productID: products[1].id, buyerID: userIDs[6], sellerID: userIDs[0], status: .ready, lockerCode: "463892", lockerLocation: "Library · Locker A3", purchaseDate: Date().addingTimeInterval(-86400), expiryDate: Date().addingTimeInterval(86400 * 2)),
        Purchase(id: UUID(), productID: products[3].id, buyerID: userIDs[6], sellerID: userIDs[3], status: .pending, lockerCode: "718534", lockerLocation: "SD Building · Locker B7", purchaseDate: Date().addingTimeInterval(-86400 * 2), expiryDate: Date().addingTimeInterval(86400)),
        Purchase(id: UUID(), productID: products[6].id, buyerID: userIDs[6], sellerID: userIDs[2], status: .expired, lockerCode: "295017", lockerLocation: "W Building · Locker C2", purchaseDate: Date().addingTimeInterval(-86400 * 10), expiryDate: Date().addingTimeInterval(-86400 * 3)),
        Purchase(id: UUID(), productID: products[4].id, buyerID: userIDs[6], sellerID: userIDs[0], status: .completed, lockerCode: "840263", lockerLocation: "ML Building · Locker D5", purchaseDate: Date().addingTimeInterval(-86400 * 14), expiryDate: Date().addingTimeInterval(-86400 * 7)),
    ]

    func product(for purchase: Purchase) -> Product? {
        products.first { $0.id == purchase.productID }
    }

    func buyer(for purchase: Purchase) -> User? {
        users.first { $0.id == purchase.buyerID }
    }

    // MARK: - Notifications
    lazy var notifications: [AppNotification] = [
        AppNotification(id: UUID(), title: "Item Sold!", message: "Your TI-84 Calculator has been purchased by Ana G.", date: Date().addingTimeInterval(-3600), isRead: false, iconName: "tag.fill"),
        AppNotification(id: UUID(), title: "Pickup Ready", message: "Your Calculus Textbook is ready for pickup at locker A-247.", date: Date().addingTimeInterval(-7200), isRead: false, iconName: "shippingbox.fill"),
        AppNotification(id: UUID(), title: "New Message", message: "Pedro L. sent you a message about MacBook Air M1.", date: Date().addingTimeInterval(-14400), isRead: false, iconName: "message.fill"),
        AppNotification(id: UUID(), title: "Price Drop Alert", message: "Sony Headphones you saved dropped to $350,000 COP.", date: Date().addingTimeInterval(-86400), isRead: true, iconName: "arrow.down.circle.fill"),
        AppNotification(id: UUID(), title: "Review Reminder", message: "How was your purchase of Physics Lab Manual? Leave a review!", date: Date().addingTimeInterval(-86400 * 2), isRead: true, iconName: "star.fill"),
    ]
}
