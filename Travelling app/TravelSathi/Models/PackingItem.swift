import Foundation

// MARK: - Packing Category
enum PackingCategory: String, CaseIterable, Identifiable {
    case documents  = "Documents"
    case clothing   = "Clothing"
    case toiletries = "Toiletries"
    case tech       = "Tech & Gadgets"
    case health     = "Health & Safety"
    case essentials = "Bag Essentials"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .documents:  return "📄"
        case .clothing:   return "👕"
        case .toiletries: return "🧴"
        case .tech:       return "📱"
        case .health:     return "💊"
        case .essentials: return "🎒"
        }
    }

    var colorHex: String {
        switch self {
        case .documents:  return "0984e3"
        case .clothing:   return "6C5CE7"
        case .toiletries: return "00B894"
        case .tech:       return "e17055"
        case .health:     return "d63031"
        case .essentials: return "FDCB6E"
        }
    }
}

// MARK: - Packing Item
struct PackingItem: Identifiable {
    let id: String
    let name: String
    let emoji: String
    let category: PackingCategory
    let travelerTypes: Set<TravelerType>   // which profiles get this item
    let destinationTypes: Set<String>      // destination tags ("Beach", "Mountain", "Heritage", etc.) — empty = all
    var isPacked: Bool = false
    let isEssential: Bool

    init(id: String = UUID().uuidString,
         name: String, emoji: String,
         category: PackingCategory,
         travelerTypes: Set<TravelerType> = Set(TravelerType.allCases),
         destinationTypes: Set<String> = [],
         isEssential: Bool = false) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.category = category
        self.travelerTypes = travelerTypes
        self.destinationTypes = destinationTypes
        self.isEssential = isEssential
    }
}

// MARK: - Packing List Model
struct PackingList {
    var items: [PackingItem]
    let travelerType: TravelerType
    let destination: Destination

    var totalCount: Int { items.count }
    var packedCount: Int { items.filter { $0.isPacked }.count }
    var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(packedCount) / Double(totalCount)
    }
    var isComplete: Bool { packedCount == totalCount }

    func items(for category: PackingCategory) -> [PackingItem] {
        items.filter { $0.category == category }
    }

    func categoriesWithItems() -> [PackingCategory] {
        PackingCategory.allCases.filter { cat in
            !items(for: cat).isEmpty
        }
    }
}
