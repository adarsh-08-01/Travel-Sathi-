import Foundation

// MARK: - Packing List Service
final class PackingListService {

    static let shared = PackingListService()
    private init() {}

    // MARK: - Generate Packing List
    func generatePackingList(for destination: Destination, profile: UserProfile) -> PackingList {
        let allItems = masterItemList()
        let destTags = Set(destination.tags)

        let filtered = allItems.filter { item in
            // Must match traveler type
            guard item.travelerTypes.contains(profile.travelerType) else { return false }
            // If item has destination restrictions, must match at least one tag
            if !item.destinationTypes.isEmpty {
                return !item.destinationTypes.isDisjoint(with: destTags)
            }
            return true
        }

        return PackingList(items: filtered, travelerType: profile.travelerType, destination: destination)
    }

    // MARK: - Master Item Database
    private func masterItemList() -> [PackingItem] {
        var items: [PackingItem] = []

        // ── DOCUMENTS ──────────────────────────────────────
        items += [
            PackingItem(name: "Aadhar Card / Govt ID", emoji: "🪪",
                        category: .documents, isEssential: true),
            PackingItem(name: "Hotel Booking Confirmation", emoji: "🏨",
                        category: .documents, isEssential: true),
            PackingItem(name: "Train / Flight Tickets", emoji: "🎫",
                        category: .documents, isEssential: true),
            PackingItem(name: "Travel Insurance", emoji: "📋",
                        category: .documents,
                        travelerTypes: [.family, .senior, .business, .workingProfessional]),
            PackingItem(name: "Business Cards", emoji: "💳",
                        category: .documents,
                        travelerTypes: [.business, .workingProfessional]),
            PackingItem(name: "Student ID Card", emoji: "🎓",
                        category: .documents,
                        travelerTypes: [.student]),
            PackingItem(name: "Emergency Contact List", emoji: "📞",
                        category: .documents,
                        travelerTypes: [.family, .senior, .soloTraveler]),
            PackingItem(name: "Doctor's Prescription", emoji: "💊",
                        category: .documents,
                        travelerTypes: [.senior]),
            PackingItem(name: "Passport (if international)", emoji: "📗",
                        category: .documents,
                        travelerTypes: [.business, .workingProfessional]),
            PackingItem(name: "Rohang Pass Permit", emoji: "📝",
                        category: .documents,
                        destinationTypes: ["Mountains", "Adventure"],
                        isEssential: true),
            PackingItem(name: "Wildlife Entry Permit", emoji: "🌿",
                        category: .documents,
                        destinationTypes: ["Nature", "Wildlife"]),
        ]

        // ── CLOTHING ───────────────────────────────────────
        items += [
            PackingItem(name: "Casual T-Shirts (3–4)", emoji: "👕",
                        category: .clothing, isEssential: true),
            PackingItem(name: "Comfortable Trousers / Jeans", emoji: "👖",
                        category: .clothing, isEssential: true),
            PackingItem(name: "Innerwear & Socks (5 pairs)", emoji: "🩲",
                        category: .clothing, isEssential: true),
            PackingItem(name: "Formal Shirt & Blazer", emoji: "👔",
                        category: .clothing,
                        travelerTypes: [.business, .workingProfessional]),
            PackingItem(name: "Business Trousers", emoji: "👔",
                        category: .clothing,
                        travelerTypes: [.business]),
            PackingItem(name: "Swimwear / Beachwear", emoji: "🩱",
                        category: .clothing,
                        destinationTypes: ["Beach", "Water Sports"]),
            PackingItem(name: "Thermal Innerwear", emoji: "🧣",
                        category: .clothing,
                        destinationTypes: ["Mountains", "Snow", "High Altitude"],
                        isEssential: true),
            PackingItem(name: "Heavy Jacket / Puffer Coat", emoji: "🧥",
                        category: .clothing,
                        destinationTypes: ["Mountains", "Snow", "High Altitude", "Trekking"],
                        isEssential: true),
            PackingItem(name: "Rain Poncho / Raincoat", emoji: "🌧️",
                        category: .clothing,
                        travelerTypes: [.student, .soloTraveler, .family],
                        destinationTypes: ["Monsoon", "Nature", "Waterfall"]),
            PackingItem(name: "Ethnic Wear (for temples)", emoji: "🥻",
                        category: .clothing,
                        destinationTypes: ["Spiritual", "Heritage", "Culture"]),
            PackingItem(name: "Kids Clothes (5 sets)", emoji: "👶",
                        category: .clothing,
                        travelerTypes: [.family]),
            PackingItem(name: "Comfortable Walking Shoes", emoji: "👟",
                        category: .clothing, isEssential: true),
            PackingItem(name: "Trekking Boots", emoji: "🥾",
                        category: .clothing,
                        destinationTypes: ["Mountains", "Trekking", "Adventure", "High Altitude"],
                        isEssential: true),
            PackingItem(name: "Flip Flops / Sandals", emoji: "🩴",
                        category: .clothing,
                        destinationTypes: ["Beach", "Spiritual", "Yoga"]),
            PackingItem(name: "Woollen Cap & Gloves", emoji: "🧤",
                        category: .clothing,
                        destinationTypes: ["Mountains", "Snow", "High Altitude"]),
            PackingItem(name: "Sunglasses", emoji: "🕶️",
                        category: .clothing,
                        destinationTypes: ["Beach", "Mountains", "Desert"]),
            PackingItem(name: "Comfortable Senior Shoes", emoji: "👞",
                        category: .clothing,
                        travelerTypes: [.senior]),
        ]

        // ── TOILETRIES ─────────────────────────────────────
        items += [
            PackingItem(name: "Toothbrush & Toothpaste", emoji: "🪥",
                        category: .toiletries, isEssential: true),
            PackingItem(name: "Shampoo & Conditioner", emoji: "🧴",
                        category: .toiletries, isEssential: true),
            PackingItem(name: "Soap / Body Wash", emoji: "🧼",
                        category: .toiletries, isEssential: true),
            PackingItem(name: "Sunscreen SPF 50+", emoji: "☀️",
                        category: .toiletries,
                        destinationTypes: ["Beach", "Mountains", "Desert"]),
            PackingItem(name: "Moisturiser (for cold weather)", emoji: "🧴",
                        category: .toiletries,
                        destinationTypes: ["Mountains", "Snow", "High Altitude"]),
            PackingItem(name: "Razor / Shaving Kit", emoji: "🪒",
                        category: .toiletries,
                        travelerTypes: [.business, .workingProfessional]),
            PackingItem(name: "Makeup & Skincare Kit", emoji: "💄",
                        category: .toiletries,
                        travelerTypes: [.workingProfessional, .business, .family]),
            PackingItem(name: "Insect Repellent", emoji: "🦟",
                        category: .toiletries,
                        destinationTypes: ["Nature", "Backwaters", "Wildlife", "Trekking"]),
            PackingItem(name: "Lip Balm (SPF)", emoji: "💋",
                        category: .toiletries,
                        destinationTypes: ["Mountains", "Beach", "Desert"]),
            PackingItem(name: "Baby Wipes & Diapers", emoji: "🍼",
                        category: .toiletries,
                        travelerTypes: [.family]),
        ]

        // ── TECH & GADGETS ─────────────────────────────────
        items += [
            PackingItem(name: "Smartphone & Charger", emoji: "📱",
                        category: .tech, isEssential: true),
            PackingItem(name: "Power Bank (10000mAh+)", emoji: "🔋",
                        category: .tech, isEssential: true),
            PackingItem(name: "Universal Travel Adapter", emoji: "🔌",
                        category: .tech,
                        travelerTypes: [.business, .workingProfessional, .soloTraveler]),
            PackingItem(name: "Laptop & Charger", emoji: "💻",
                        category: .tech,
                        travelerTypes: [.business, .workingProfessional]),
            PackingItem(name: "Earphones / Earbuds", emoji: "🎧",
                        category: .tech),
            PackingItem(name: "Noise-Cancelling Headphones", emoji: "🎧",
                        category: .tech,
                        travelerTypes: [.business, .workingProfessional]),
            PackingItem(name: "Camera / GoPro", emoji: "📷",
                        category: .tech,
                        travelerTypes: [.soloTraveler, .student, .family, .senior]),
            PackingItem(name: "Hostel Padlock", emoji: "🔒",
                        category: .tech,
                        travelerTypes: [.student, .soloTraveler]),
            PackingItem(name: "Offline Maps Downloaded", emoji: "🗺️",
                        category: .tech, isEssential: true),
            PackingItem(name: "E-Reader / Books / Kindle", emoji: "📚",
                        category: .tech,
                        travelerTypes: [.senior, .soloTraveler, .workingProfessional]),
            PackingItem(name: "Kids Tablet / Entertainment", emoji: "📺",
                        category: .tech,
                        travelerTypes: [.family]),
            PackingItem(name: "Selfie Stick & Tripod", emoji: "🤳",
                        category: .tech,
                        travelerTypes: [.student, .soloTraveler]),
        ]

        // ── HEALTH & SAFETY ────────────────────────────────
        items += [
            PackingItem(name: "Basic First Aid Kit", emoji: "🩹",
                        category: .health, isEssential: true),
            PackingItem(name: "Pain Relievers (Paracetamol)", emoji: "💊",
                        category: .health, isEssential: true),
            PackingItem(name: "ORS Sachets (for dehydration)", emoji: "💧",
                        category: .health,
                        destinationTypes: ["Beach", "Mountains", "High Altitude"]),
            PackingItem(name: "Altitude Sickness Pills", emoji: "🏔️",
                        category: .health,
                        destinationTypes: ["Mountains", "High Altitude", "Adventure"],
                        isEssential: true),
            PackingItem(name: "Personal Prescription Meds", emoji: "💊",
                        category: .health,
                        travelerTypes: [.senior]),
            PackingItem(name: "Antacid / Digestive Tablets", emoji: "🤢",
                        category: .health),
            PackingItem(name: "Anti-Mosquito Patches", emoji: "🦟",
                        category: .health,
                        destinationTypes: ["Nature", "Backwaters", "Wildlife"]),
            PackingItem(name: "Sanitizer & Face Masks", emoji: "🧴",
                        category: .health, isEssential: true),
            PackingItem(name: "Travel Pillow (for flights)", emoji: "😴",
                        category: .health,
                        travelerTypes: [.senior, .business, .workingProfessional]),
            PackingItem(name: "Kids Fever Syrup & Drops", emoji: "🩺",
                        category: .health,
                        travelerTypes: [.family]),
            PackingItem(name: "Earplugs (for hostels)", emoji: "👂",
                        category: .health,
                        travelerTypes: [.student, .soloTraveler]),
        ]

        // ── BAG ESSENTIALS ─────────────────────────────────
        items += [
            PackingItem(name: "Backpack / Trolley Bag", emoji: "🎒",
                        category: .essentials, isEssential: true),
            PackingItem(name: "Day Pack (small backpack)", emoji: "👜",
                        category: .essentials,
                        travelerTypes: [.student, .soloTraveler, .workingProfessional, .family]),
            PackingItem(name: "Cash (₹2,000–₹5,000)", emoji: "💵",
                        category: .essentials, isEssential: true),
            PackingItem(name: "UPI / Debit Card", emoji: "💳",
                        category: .essentials, isEssential: true),
            PackingItem(name: "Reusable Water Bottle", emoji: "🍶",
                        category: .essentials, isEssential: true),
            PackingItem(name: "Energy Snacks & Trail Mix", emoji: "🍫",
                        category: .essentials,
                        travelerTypes: [.student, .soloTraveler, .family],
                        destinationTypes: ["Mountains", "Trekking", "Adventure"]),
            PackingItem(name: "Packing Cubes", emoji: "📦",
                        category: .essentials,
                        travelerTypes: [.business, .workingProfessional, .senior]),
            PackingItem(name: "Small Torch / Flashlight", emoji: "🔦",
                        category: .essentials,
                        destinationTypes: ["Mountains", "Adventure", "Trekking", "Camping"]),
            PackingItem(name: "Laundry Bag", emoji: "👜",
                        category: .essentials,
                        travelerTypes: [.family, .soloTraveler, .senior]),
            PackingItem(name: "Travel Umbrella", emoji: "☂️",
                        category: .essentials),
            PackingItem(name: "Safety Whistle", emoji: "📣",
                        category: .essentials,
                        travelerTypes: [.soloTraveler, .student],
                        destinationTypes: ["Mountains", "Trekking", "Adventure"]),
            PackingItem(name: "Stroller / Kids Carrier", emoji: "🛒",
                        category: .essentials,
                        travelerTypes: [.family]),
        ]

        return items
    }
}
