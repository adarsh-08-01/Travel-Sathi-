import SwiftUI

// MARK: - Color Extensions
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Color Theme
struct AppColors {
    // Backgrounds
    static let backgroundDeep   = Color(hex: "0D0D1A")
    static let backgroundCard   = Color(hex: "1A1A2E")
    static let backgroundSurface = Color(hex: "16213E")

    // Brand
    static let primary          = Color(hex: "6C5CE7")
    static let primaryLight     = Color(hex: "a29bfe")
    static let secondary        = Color(hex: "00B894")
    static let secondaryLight   = Color(hex: "55efc4")
    static let accent           = Color(hex: "FDCB6E")
    static let accentWarm       = Color(hex: "e17055")

    // Text
    static let textPrimary      = Color(hex: "FFFFFF")
    static let textSecondary    = Color(hex: "A0A0C0")
    static let textTertiary     = Color(hex: "6C6C8A")

    // Budget tiers
    static let budgetLow        = Color(hex: "00B894")
    static let budgetMedium     = Color(hex: "6C5CE7")
    static let budgetHigh       = Color(hex: "FDCB6E")

    // Rating
    static let starFilled       = Color(hex: "FDCB6E")
    static let starEmpty        = Color(hex: "3A3A5C")

    // Gradients
    static let gradientPrimary  = LinearGradient(
        colors: [Color(hex: "6C5CE7"), Color(hex: "a29bfe")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let gradientSecondary = LinearGradient(
        colors: [Color(hex: "00B894"), Color(hex: "55efc4")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let gradientAccent   = LinearGradient(
        colors: [Color(hex: "e17055"), Color(hex: "FDCB6E")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let gradientBackground = LinearGradient(
        colors: [Color(hex: "0D0D1A"), Color(hex: "1A1A2E"), Color(hex: "16213E")],
        startPoint: .top, endPoint: .bottom
    )
}

// MARK: - Destination Gradients
extension AppColors {
    static let destinationGradients: [[Color]] = [
        [Color(hex: "6C5CE7"), Color(hex: "a29bfe")],
        [Color(hex: "00B894"), Color(hex: "55efc4")],
        [Color(hex: "e17055"), Color(hex: "FDCB6E")],
        [Color(hex: "0984e3"), Color(hex: "74b9ff")],
        [Color(hex: "d63031"), Color(hex: "ff7675")],
        [Color(hex: "6d4c41"), Color(hex: "bcaaa4")],
        [Color(hex: "2d3436"), Color(hex: "636e72")],
        [Color(hex: "00cec9"), Color(hex: "81ecec")],
    ]
}
