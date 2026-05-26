import Foundation

// MARK: - Destination Model
struct Destination: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let state: String
    let description: String
    let longDescription: String
    let gradientStart: String   // hex color
    let gradientEnd: String     // hex color
    let tags: [String]
    let bestTimeToVisit: String
    let avgTemperature: String
    let sfSymbol: String
    let popularFor: [String]
    let travelTip: String

    var fullLocation: String { "\(name), \(state)" }

    static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
