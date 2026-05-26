import Foundation

// MARK: - Recommendation Category
enum RecommendationCategory: String, CaseIterable, Identifiable, Codable {
    case hotels    = "Hotels"
    case food      = "Food"
    case sights    = "Sights"
    case transport = "Transport"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .hotels:    return "🏨"
        case .food:      return "🍽️"
        case .sights:    return "🏛️"
        case .transport: return "🚌"
        }
    }

    var sfSymbol: String {
        switch self {
        case .hotels:    return "bed.double.fill"
        case .food:      return "fork.knife"
        case .sights:    return "binoculars.fill"
        case .transport: return "bus.fill"
        }
    }

    var colorHex: String {
        switch self {
        case .hotels:    return "6C5CE7"
        case .food:      return "e17055"
        case .sights:    return "00B894"
        case .transport: return "0984e3"
        }
    }
}

// MARK: - Recommendation
struct Recommendation: Identifiable, Codable {
    let id: String
    let name: String
    let category: RecommendationCategory
    let description: String
    let priceEstimate: String
    let priceValue: Double   // numeric for sorting
    let rating: Double
    let budgetTier: BudgetTier
    let tags: [String]
    let tips: [String]
    let sfSymbol: String
    let gradientStart: String
    let gradientEnd: String
    let address: String
    let openHours: String

    var budgetFitLabel: String {
        switch budgetTier {
        case .low:    return "Budget Friendly"
        case .medium: return "Mid Range"
        case .high:   return "Premium"
        }
    }

    var ratingFormatted: String {
        String(format: "%.1f", rating)
    }
}

// MARK: - Trip Plan
struct TripPlan: Identifiable {
    let id: String
    let destination: Destination
    let userProfile: UserProfile
    let allRecommendations: [Recommendation]
    let generatedDate: Date
    let tripDuration: String
    let highlights: [String]
    let budgetBreakdown: BudgetBreakdown

    // Filtered by user's budget tier
    var recommendations: [Recommendation] {
        allRecommendations.filter { $0.budgetTier == userProfile.budgetTier }
    }

    func recommendations(for category: RecommendationCategory) -> [Recommendation] {
        recommendations.filter { $0.category == category }
    }
}

// MARK: - Budget Breakdown
struct BudgetBreakdown {
    let accommodation: String
    let food: String
    let sightseeing: String
    let transport: String
    let total: String
    let budgetTier: BudgetTier
}
