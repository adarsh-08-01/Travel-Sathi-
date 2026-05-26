import Foundation

// MARK: - Trip Mood
enum TripMood: String, CaseIterable, Identifiable {
    case amazing     = "Amazing"
    case good        = "Good"
    case okay        = "Okay"
    case disappointed = "Disappointed"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .amazing:      return "🤩"
        case .good:         return "😊"
        case .okay:         return "😐"
        case .disappointed: return "😞"
        }
    }

    var colorHex: String {
        switch self {
        case .amazing:      return "FDCB6E"
        case .good:         return "00B894"
        case .okay:         return "6C5CE7"
        case .disappointed: return "e17055"
        }
    }
}

// MARK: - Trip Feedback
struct TripFeedback: Identifiable {
    let id: String
    var rating: Int = 0
    var mood: TripMood = .good
    var notes: String = ""
    var wouldRecommend: Bool = true
    let submittedDate: Date

    init(id: String = UUID().uuidString, submittedDate: Date = Date()) {
        self.id = id
        self.submittedDate = submittedDate
    }

    var isValid: Bool {
        rating > 0
    }
}
