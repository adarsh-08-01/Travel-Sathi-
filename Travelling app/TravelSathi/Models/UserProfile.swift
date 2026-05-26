import Foundation

// MARK: - Traveler Type
enum TravelerType: String, CaseIterable, Identifiable, Codable {
    case student            = "Student"
    case workingProfessional = "Working Professional"
    case family             = "Family Person"
    case business           = "Business Owner"
    case soloTraveler       = "Solo Traveler"
    case senior             = "Senior Citizen"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .student:             return "🎓"
        case .workingProfessional: return "💼"
        case .family:              return "👨‍👩‍👧‍👦"
        case .business:            return "🏢"
        case .soloTraveler:        return "🎒"
        case .senior:              return "🌿"
        }
    }

    var tagline: String {
        switch self {
        case .student:             return "Budget-smart adventures"
        case .workingProfessional: return "Quick escapes, premium comfort"
        case .family:              return "Safe & fun for all ages"
        case .business:            return "Business + leisure blend"
        case .soloTraveler:        return "Freedom & exploration"
        case .senior:              return "Relaxed, comfortable trips"
        }
    }

    var primaryColor: String {
        switch self {
        case .student:             return "6C5CE7"
        case .workingProfessional: return "0984e3"
        case .family:              return "00B894"
        case .business:            return "e17055"
        case .soloTraveler:        return "FDCB6E"
        case .senior:              return "a29bfe"
        }
    }
}

// MARK: - Budget Tier
enum BudgetTier: String, CaseIterable, Codable, Identifiable {
    case low    = "Low"
    case medium = "Medium"
    case high   = "High"

    var id: String { rawValue }

    var label: String { rawValue }

    var range: String {
        switch self {
        case .low:    return "Under ₹5,000"
        case .medium: return "₹5,000 – ₹15,000"
        case .high:   return "Above ₹15,000"
        }
    }

    var emoji: String {
        switch self {
        case .low:    return "💰"
        case .medium: return "💳"
        case .high:   return "💎"
        }
    }

    var colorHex: String {
        switch self {
        case .low:    return "00B894"
        case .medium: return "6C5CE7"
        case .high:   return "FDCB6E"
        }
    }
}

// MARK: - User Profile
struct UserProfile: Codable {
    var name: String = ""
    var travelerType: TravelerType = .student
    var budgetTier: BudgetTier = .medium
    var customBudget: Double? = nil

    var displayBudget: String {
        if let custom = customBudget {
            let formatted = NumberFormatter.currencyFormatter.string(from: NSNumber(value: custom)) ?? "₹\(Int(custom))"
            return formatted
        }
        return budgetTier.range
    }

    var isComplete: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

// MARK: - NumberFormatter
extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencySymbol = "₹"
        f.maximumFractionDigits = 0
        return f
    }()
}
