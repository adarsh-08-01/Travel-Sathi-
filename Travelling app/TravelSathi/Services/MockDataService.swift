import Foundation

// MARK: - Mock Data Service
final class MockDataService {

    static let shared = MockDataService()
    private init() {}

    // MARK: - All Destinations
    let destinations: [Destination] = [
        Destination(
            id: "goa",
            name: "Goa",
            state: "Goa",
            description: "Sun, sand, and vibrant nightlife on India's favourite coast.",
            longDescription: "Goa is India's smallest state, nestled on the western coast. It is famous for its stunning beaches, Portuguese colonial architecture, world-class seafood, and legendary nightlife. From peaceful Arambol in the north to lively Calangute and tranquil Palolem in the south, Goa has something for every traveler.",
            gradientStart: "0984e3",
            gradientEnd: "74b9ff",
            tags: ["Beach", "Nightlife", "Seafood", "Party", "Water Sports"],
            bestTimeToVisit: "November – February",
            avgTemperature: "23–32°C",
            sfSymbol: "beach.umbrella.fill",
            popularFor: ["Baga Beach", "Anjuna Flea Market", "Fort Aguada", "Dudhsagar Falls", "Old Goa Churches"],
            travelTip: "Rent a scooter — it's the best way to explore Goa's winding lanes and hidden beaches."
        ),
        Destination(
            id: "manali",
            name: "Manali",
            state: "Himachal Pradesh",
            description: "Himalayan paradise with snow peaks, adventure sports, and pine forests.",
            longDescription: "Manali is a high-altitude Himalayan resort town in the Kullu Valley. It is a gateway to Leh-Ladakh and Spiti Valley. Famous for its stunning mountain scenery, adventure activities like skiing, paragliding and trekking, and the mystical Rohtang Pass.",
            gradientStart: "6C5CE7",
            gradientEnd: "a29bfe",
            tags: ["Mountains", "Adventure", "Snow", "Trekking", "Honeymoon"],
            bestTimeToVisit: "October – June",
            avgTemperature: "-5–25°C",
            sfSymbol: "mountain.2.fill",
            popularFor: ["Rohtang Pass", "Solang Valley", "Hadimba Temple", "Beas River", "Kullu Valley"],
            travelTip: "Book accommodation early during peak season (Dec–Jan) as snow fills up popular spots fast."
        ),
        Destination(
            id: "jaipur",
            name: "Jaipur",
            state: "Rajasthan",
            description: "The Pink City — royal palaces, vibrant bazaars, and rich Rajasthani culture.",
            longDescription: "Jaipur, the capital of Rajasthan, is part of India's famous Golden Triangle tourist circuit. Known as the Pink City for its distinctive rose-coloured buildings, Jaipur is home to magnificent Rajput-era palaces, forts, and colourful bazaars selling textiles, jewellery, and handicrafts.",
            gradientStart: "e17055",
            gradientEnd: "FDCB6E",
            tags: ["Heritage", "Culture", "Shopping", "Forts", "Royalty"],
            bestTimeToVisit: "October – March",
            avgTemperature: "15–35°C",
            sfSymbol: "building.columns.fill",
            popularFor: ["Hawa Mahal", "Amber Fort", "City Palace", "Jantar Mantar", "Johari Bazaar"],
            travelTip: "Hire a local auto-rickshaw for ₹200–300 for a full-day sightseeing tour inside the walled city."
        ),
        Destination(
            id: "kerala",
            name: "Kerala (Munnar)",
            state: "Kerala",
            description: "God's Own Country — backwaters, tea plantations, and Ayurvedic wellness.",
            longDescription: "Munnar is a hill station in the Western Ghats of Kerala, surrounded by vast stretches of tea, coffee, and spice plantations. Kerala's backwaters, houseboats, and Ayurvedic resorts make it one of India's most unique travel destinations.",
            gradientStart: "00B894",
            gradientEnd: "55efc4",
            tags: ["Nature", "Wellness", "Tea", "Backwaters", "Ayurveda"],
            bestTimeToVisit: "September – March",
            avgTemperature: "10–28°C",
            sfSymbol: "leaf.fill",
            popularFor: ["Mattupetty Dam", "Eravikulam National Park", "Tea Gardens", "Attukal Waterfalls", "Alleppey Backwaters"],
            travelTip: "Book a houseboat stay in Alleppey for an unforgettable night on the backwaters."
        ),
        Destination(
            id: "ladakh",
            name: "Ladakh",
            state: "Ladakh (UT)",
            description: "The Land of High Passes — stark landscapes, ancient monasteries, and starry skies.",
            longDescription: "Ladakh is one of the world's most spectacular high-altitude deserts, situated in the northernmost part of India. Its dramatic landscape of rugged mountains, vast plains, and pristine lakes, combined with ancient Tibetan Buddhist culture and monasteries, makes it a bucket-list destination.",
            gradientStart: "2d3436",
            gradientEnd: "636e72",
            tags: ["Adventure", "Mountains", "Monasteries", "Biking", "Stargazing"],
            bestTimeToVisit: "June – September",
            avgTemperature: "-15–25°C",
            sfSymbol: "moon.stars.fill",
            popularFor: ["Pangong Lake", "Nubra Valley", "Thiksey Monastery", "Leh Palace", "Magnetic Hill"],
            travelTip: "Spend 2–3 days in Leh acclimatising before heading to high-altitude passes to avoid altitude sickness."
        ),
        Destination(
            id: "varanasi",
            name: "Varanasi",
            state: "Uttar Pradesh",
            description: "One of the world's oldest cities — ghats, Ganga Aarti, and spiritual awakening.",
            longDescription: "Varanasi, also known as Kashi or Banaras, is one of the oldest continuously inhabited cities in the world and the spiritual capital of India. Situated on the banks of the holy Ganges river, it is a centre of learning, music, arts, and Hindu pilgrimage.",
            gradientStart: "d63031",
            gradientEnd: "ff7675",
            tags: ["Spiritual", "Culture", "Heritage", "Ghats", "Food"],
            bestTimeToVisit: "October – March",
            avgTemperature: "10–38°C",
            sfSymbol: "flame.fill",
            popularFor: ["Dashashwamedh Ghat", "Ganga Aarti", "Kashi Vishwanath Temple", "Sarnath", "Boat Ride on Ganges"],
            travelTip: "Wake up early at 5 AM for a boat ride at sunrise — it's the most magical experience in the city."
        ),
        Destination(
            id: "rishikesh",
            name: "Rishikesh",
            state: "Uttarakhand",
            description: "Yoga capital of the world — adventure, spirituality, and the sacred Ganges.",
            longDescription: "Rishikesh is a city on the Ganges river in India's Uttarakhand state. It's considered a holy city and is known as the Yoga Capital of the World. It's also an adventure sports hub offering river rafting, bungee jumping, and trekking in the Himalayan foothills.",
            gradientStart: "00cec9",
            gradientEnd: "81ecec",
            tags: ["Yoga", "Adventure", "Spiritual", "Rafting", "Camping"],
            bestTimeToVisit: "February – May, September – November",
            avgTemperature: "10–35°C",
            sfSymbol: "water.waves",
            popularFor: ["Lakshman Jhula", "River Rafting", "Bungee Jumping", "Beatles Ashram", "Triveni Ghat Aarti"],
            travelTip: "The Ganga Aarti at Triveni Ghat at sunset is a must-see — arrive 30 mins early for a good spot."
        ),
        Destination(
            id: "agra",
            name: "Agra",
            state: "Uttar Pradesh",
            description: "Home to the Taj Mahal — an eternal monument of love and Mughal grandeur.",
            longDescription: "Agra is a city on the banks of the Yamuna river in the northern state of Uttar Pradesh. It is best known as the site of the Taj Mahal, one of the Seven Wonders of the World and a UNESCO World Heritage Site. The city also has two other UNESCO-listed Mughal sites: Agra Fort and Fatehpur Sikri.",
            gradientStart: "6d4c41",
            gradientEnd: "bcaaa4",
            tags: ["Heritage", "UNESCO", "Photography", "Mughal", "Romance"],
            bestTimeToVisit: "October – March",
            avgTemperature: "5–40°C",
            sfSymbol: "star.fill",
            popularFor: ["Taj Mahal", "Agra Fort", "Fatehpur Sikri", "Mehtab Bagh", "Kinari Bazaar"],
            travelTip: "Buy a composite ticket for Taj Mahal, Agra Fort, and Fatehpur Sikri — it saves money and is valid for 2 days."
        ),
    ]

    // MARK: - Recommendations Database
    func recommendations(for destinationId: String) -> [Recommendation] {
        switch destinationId {
        case "goa":       return goaRecommendations
        case "manali":    return manaliRecommendations
        case "jaipur":    return jaipurRecommendations
        case "kerala":    return keralaRecommendations
        case "ladakh":    return ladakhRecommendations
        case "varanasi":  return varanasiRecommendations
        case "rishikesh": return rishikeshRecommendations
        case "agra":      return agraRecommendations
        default:          return goaRecommendations
        }
    }

    // MARK: - Generate Trip Plan
    func generateTripPlan(destination: Destination, profile: UserProfile) -> TripPlan {
        let recs = recommendations(for: destination.id)
        let breakdown = budgetBreakdown(for: destination, profile: profile)
        let duration = tripDuration(for: profile)
        let highlights = tripHighlights(for: destination, profile: profile)
        return TripPlan(
            id: UUID().uuidString,
            destination: destination,
            userProfile: profile,
            allRecommendations: recs,
            generatedDate: Date(),
            tripDuration: duration,
            highlights: highlights,
            budgetBreakdown: breakdown
        )
    }

    private func tripDuration(for profile: UserProfile) -> String {
        switch profile.travelerType {
        case .student:             return "3–4 Days"
        case .workingProfessional: return "2–3 Days"
        case .family:              return "4–5 Days"
        case .business:            return "2 Days"
        case .soloTraveler:        return "5–7 Days"
        case .senior:              return "4–6 Days"
        }
    }

    private func tripHighlights(for destination: Destination, profile: UserProfile) -> [String] {
        let baseHighlights = destination.popularFor.prefix(3).map { $0 }
        switch profile.budgetTier {
        case .low:    return baseHighlights + ["Budget street food trail", "Free local experiences"]
        case .medium: return baseHighlights + ["Curated day tours", "Local restaurant dining"]
        case .high:   return baseHighlights + ["Luxury resort stay", "Private guided tours"]
        }
    }

    private func budgetBreakdown(for destination: Destination, profile: UserProfile) -> BudgetBreakdown {
        switch profile.budgetTier {
        case .low:
            return BudgetBreakdown(
                accommodation: "₹500–₹1,200/night",
                food: "₹200–₹400/day",
                sightseeing: "₹100–₹500/day",
                transport: "₹300–₹800",
                total: "₹2,000–₹5,000",
                budgetTier: .low
            )
        case .medium:
            return BudgetBreakdown(
                accommodation: "₹1,500–₹4,000/night",
                food: "₹600–₹1,200/day",
                sightseeing: "₹500–₹1,500/day",
                transport: "₹800–₹2,500",
                total: "₹6,000–₹15,000",
                budgetTier: .medium
            )
        case .high:
            return BudgetBreakdown(
                accommodation: "₹5,000–₹20,000/night",
                food: "₹1,500–₹4,000/day",
                sightseeing: "₹2,000–₹5,000/day",
                transport: "₹3,000–₹8,000",
                total: "₹18,000–₹50,000+",
                budgetTier: .high
            )
        }
    }

    // MARK: - GOA
    private var goaRecommendations: [Recommendation] {[
        // Hotels – Low
        Recommendation(id: "goa-h1", name: "Zostel Goa", category: .hotels,
            description: "Vibrant backpacker hostel on Baga beach with a rooftop cafe, fun crowd, and free breakfast. Perfect for solo travelers and students looking for budget stays.",
            priceEstimate: "₹450–₹800/night", priceValue: 600, rating: 4.3, budgetTier: .low,
            tags: ["Hostel", "Backpacker", "Social", "Beach Nearby"],
            tips: ["Book dorm beds in advance", "Join the evening bonfire", "Free wifi throughout"],
            sfSymbol: "house.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Baga Road, Calangute, Goa", openHours: "24/7"),
        Recommendation(id: "goa-h2", name: "OYO Rooms Anjuna", category: .hotels,
            description: "Clean, comfortable budget rooms near Anjuna Beach. Ideal for couples and small groups wanting basic amenities at pocket-friendly rates.",
            priceEstimate: "₹700–₹1,200/night", priceValue: 900, rating: 3.8, budgetTier: .low,
            tags: ["Budget", "Clean", "AC Rooms", "Beach Access"],
            tips: ["Ask for beach-facing room", "Negotiate for longer stays"],
            sfSymbol: "bed.double.fill", gradientStart: "6C5CE7", gradientEnd: "a29bfe",
            address: "Anjuna Village, North Goa", openHours: "24/7"),
        // Hotels – Medium
        Recommendation(id: "goa-h3", name: "Treehouse Goa Resort", category: .hotels,
            description: "A boutique eco-resort with charming treehouse cottages nestled in a tropical garden. Perfect for a romantic or relaxing escape with a pool and organic cafe.",
            priceEstimate: "₹3,500–₹6,000/night", priceValue: 4500, rating: 4.6, budgetTier: .medium,
            tags: ["Boutique", "Eco", "Pool", "Garden", "Romantic"],
            tips: ["Request garden-view cottage", "Breakfast included", "Quiet location away from parties"],
            sfSymbol: "tree.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Assagao, North Goa", openHours: "24/7"),
        Recommendation(id: "goa-h4", name: "Hyatt Place Goa", category: .hotels,
            description: "Contemporary hotel with stylish rooms, rooftop pool, and modern amenities. Great central location for exploring both North Goa and the Panjim city area.",
            priceEstimate: "₹4,500–₹8,000/night", priceValue: 6000, rating: 4.5, budgetTier: .medium,
            tags: ["Business", "Pool", "Rooftop", "Modern"],
            tips: ["Happy hour at rooftop bar 6–8 PM", "Free airport shuttle on request"],
            sfSymbol: "building.fill", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Candolim, North Goa", openHours: "24/7"),
        // Hotels – High
        Recommendation(id: "goa-h5", name: "Taj Exotica Resort & Spa", category: .hotels,
            description: "Goa's most iconic luxury resort. Set on a pristine beach with private butler service, a world-class spa, multiple restaurants, and an infinity pool overlooking the Arabian Sea.",
            priceEstimate: "₹18,000–₹35,000/night", priceValue: 25000, rating: 4.9, budgetTier: .high,
            tags: ["Luxury", "Spa", "Butler Service", "Beach", "Fine Dining"],
            tips: ["Book the Portuguese suite for best sea views", "Spa appointments fill up fast"],
            sfSymbol: "star.fill", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Benaulim, South Goa", openHours: "24/7"),

        // Food – Low
        Recommendation(id: "goa-f1", name: "Fisherman's Wharf Beach Shack", category: .food,
            description: "Iconic beach shack known for fresh catch-of-the-day at unbeatable prices. Order the grilled pomfret and fresh lime soda — a Goa classic.",
            priceEstimate: "₹150–₹400/meal", priceValue: 250, rating: 4.2, budgetTier: .low,
            tags: ["Seafood", "Beach Shack", "Local", "Fresh Fish"],
            tips: ["Go for lunch when fish is freshest", "The sol kadhi (kokum drink) is a must"],
            sfSymbol: "fork.knife", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Calangute Beach, North Goa", openHours: "8 AM – 10 PM"),
        Recommendation(id: "goa-f2", name: "Vinayak's Canteen", category: .food,
            description: "A local legend — Goan thali served on banana leaf with fish curry, rice, dal, and papad. Lunch only, arrives before 1 PM for fresh batches.",
            priceEstimate: "₹80–₹150/thali", priceValue: 120, rating: 4.5, budgetTier: .low,
            tags: ["Local", "Thali", "Authentic", "Goan Cuisine"],
            tips: ["Only open for lunch", "Cash only", "Arrive early — sells out by 2 PM"],
            sfSymbol: "fork.knife", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Panaji Market, Goa", openHours: "11 AM – 3 PM"),
        // Food – Medium
        Recommendation(id: "goa-f3", name: "Calamari Restaurant", category: .food,
            description: "A mid-range seafood restaurant with a romantic terrace setting. Known for Goan prawn curry, crab masala, and a great wine selection. Sunset views included.",
            priceEstimate: "₹600–₹1,200/person", priceValue: 900, rating: 4.4, budgetTier: .medium,
            tags: ["Seafood", "Romantic", "Terrace", "Sunset Views"],
            tips: ["Reserve a terrace table for sunset", "Try the Goan sorpotel starter"],
            sfSymbol: "fork.knife", gradientStart: "6C5CE7", gradientEnd: "a29bfe",
            address: "Sinquerim, North Goa", openHours: "12 PM – 11 PM"),
        // Food – High
        Recommendation(id: "goa-f4", name: "Martin's Corner", category: .food,
            description: "Goa's most celebrated fine dining restaurant. Legendary for serving celebrities and politicians. Their butter garlic lobster and crab xacuti are unforgettable.",
            priceEstimate: "₹2,000–₹4,000/person", priceValue: 3000, rating: 4.7, budgetTier: .high,
            tags: ["Fine Dining", "Luxury", "Celebrity Spot", "Lobster"],
            tips: ["Reservation mandatory on weekends", "Ask for the special tasting menu"],
            sfSymbol: "star.fill", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Betalbatim, South Goa", openHours: "12 PM – 3 PM, 7 PM – 11 PM"),

        // Sights – All Tiers
        Recommendation(id: "goa-s1", name: "Baga & Calangute Beach", category: .sights,
            description: "North Goa's most popular beaches with endless water sports, beach shacks, and a lively atmosphere. Great for swimming, jet-skiing, and people-watching.",
            priceEstimate: "Free (water sports ₹400–₹1,500)", priceValue: 0, rating: 4.3, budgetTier: .low,
            tags: ["Beach", "Water Sports", "Free", "Popular"],
            tips: ["Avoid midday heat — go early morning or late afternoon", "Haggle for water sports prices"],
            sfSymbol: "beach.umbrella.fill", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Calangute, North Goa", openHours: "Always Open"),
        Recommendation(id: "goa-s2", name: "Fort Aguada", category: .sights,
            description: "A 17th-century Portuguese fort offering panoramic views of the Arabian Sea. The old lighthouse and ramparts make for spectacular photography.",
            priceEstimate: "₹25 entry", priceValue: 25, rating: 4.4, budgetTier: .low,
            tags: ["Heritage", "Fort", "Views", "Photography"],
            tips: ["Visit at golden hour for best light", "Combine with Sinquerim Beach below"],
            sfSymbol: "binoculars.fill", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Sinquerim, Candolim, Goa", openHours: "9:30 AM – 5:30 PM"),
        Recommendation(id: "goa-s3", name: "Dudhsagar Waterfalls", category: .sights,
            description: "One of India's tallest waterfalls at 310 metres — a stunning four-tiered cascade on the Goa-Karnataka border. Best visited after the monsoon.",
            priceEstimate: "₹600 jeep safari package", priceValue: 600, rating: 4.7, budgetTier: .medium,
            tags: ["Waterfall", "Nature", "Adventure", "Photography"],
            tips: ["Book jeep safari from Kulem station", "Visit October–December for full flow", "Bring waterproof bags"],
            sfSymbol: "drop.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Bhagwan Mahaveer Sanctuary, Goa", openHours: "7 AM – 4 PM"),

        // Transport – All Tiers
        Recommendation(id: "goa-t1", name: "Scooter Rental", category: .transport,
            description: "The quintessential Goa experience. Rent an Activa or scooter from any beach shack for complete freedom to explore at your own pace.",
            priceEstimate: "₹300–₹500/day", priceValue: 400, rating: 4.6, budgetTier: .low,
            tags: ["Scooter", "Freedom", "Best Value", "Popular"],
            tips: ["Carry your driving license", "Tank up at petrol pumps — avoid overpriced beach fuel", "Helmets mandatory"],
            sfSymbol: "bicycle", gradientStart: "FDCB6E", gradientEnd: "e17055",
            address: "Available at all major beaches", openHours: "7 AM – 9 PM"),
        Recommendation(id: "goa-t2", name: "Private Cab (Rapido/OLA)", category: .transport,
            description: "Air-conditioned cabs for comfortable transfers between North and South Goa. Ideal for families, seniors, or when you have luggage.",
            priceEstimate: "₹150–₹600/trip", priceValue: 300, rating: 4.0, budgetTier: .medium,
            tags: ["Cab", "Comfortable", "AC", "Family-friendly"],
            tips: ["Use OLA or Goa-specific apps like GoaMiles", "Book airport transfers in advance"],
            sfSymbol: "car.fill", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Available across Goa", openHours: "24/7"),
    ]}

    // MARK: - MANALI
    private var manaliRecommendations: [Recommendation] {[
        Recommendation(id: "man-h1", name: "Zostel Manali", category: .hotels,
            description: "Award-winning hostel with stunning mountain views, cozy dorms, a bonfire every night, and a community of fellow travellers. Best budget stay in Manali.",
            priceEstimate: "₹500–₹900/night", priceValue: 700, rating: 4.5, budgetTier: .low,
            tags: ["Hostel", "Mountain View", "Bonfire", "Backpacker"],
            tips: ["Book the private pods for more privacy", "Great spot to find trek partners"],
            sfSymbol: "house.fill", gradientStart: "6C5CE7", gradientEnd: "a29bfe",
            address: "Old Manali Road, Himachal Pradesh", openHours: "24/7"),
        Recommendation(id: "man-h2", name: "Manuallaya Resort & Spa", category: .hotels,
            description: "A riverside mid-range resort with luxury cottages set amidst apple orchards and pine trees. Stunning views of the Beas river and Himalayan peaks.",
            priceEstimate: "₹4,500–₹8,000/night", priceValue: 6000, rating: 4.6, budgetTier: .medium,
            tags: ["Resort", "River View", "Spa", "Apple Orchard", "Cottages"],
            tips: ["Request a river-facing cottage", "Spa bookings need advance reservation"],
            sfSymbol: "tree.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Prini Village, Kullu District, HP", openHours: "24/7"),
        Recommendation(id: "man-h3", name: "Solang Valley Resort", category: .hotels,
            description: "Luxury mountain resort at the gateway to Solang Valley. Offers ski packages in winter, bonfire dinners, and breathtaking snow-capped peak views.",
            priceEstimate: "₹10,000–₹22,000/night", priceValue: 15000, rating: 4.7, budgetTier: .high,
            tags: ["Luxury", "Ski Resort", "Snow Views", "Premium"],
            tips: ["Book ski packages in December–February", "Complimentary valley transfer included"],
            sfSymbol: "star.fill", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Solang Valley, Manali", openHours: "24/7"),
        Recommendation(id: "man-f1", name: "Johnson's Café", category: .food,
            description: "Legendary Manali institution run by a retired colonel. Known for its world-class trout, apple pie, and wood-fire ambience. A must-visit for every visitor.",
            priceEstimate: "₹400–₹900/person", priceValue: 600, rating: 4.8, budgetTier: .medium,
            tags: ["Trout", "Apple Pie", "Iconic", "Wood Fire"],
            tips: ["Try the river-fresh trout", "Reserve for dinner — always packed"],
            sfSymbol: "fork.knife", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Circuit House Road, Manali", openHours: "7 AM – 10 PM"),
        Recommendation(id: "man-f2", name: "Shere-E-Punjab Dhaba", category: .food,
            description: "The best budget dhaba in Manali serving hot dal makhani, butter naan, and rajma chawal. Perfect fuel for trekking days at unbeatable prices.",
            priceEstimate: "₹100–₹200/meal", priceValue: 150, rating: 4.2, budgetTier: .low,
            tags: ["Dhaba", "North Indian", "Budget", "Hearty"],
            tips: ["Try the rajma chawal — it's famous here", "Opens early for trekkers at 6 AM"],
            sfSymbol: "fork.knife", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Mall Road, Manali", openHours: "6 AM – 10 PM"),
        Recommendation(id: "man-s1", name: "Rohtang Pass", category: .sights,
            description: "The iconic Himalayan pass at 3,978 metres offering otherworldly snow landscapes, glacier views, and the surreal feeling of being on top of the world.",
            priceEstimate: "₹600 permit + taxi ₹1,500", priceValue: 2100, rating: 4.7, budgetTier: .medium,
            tags: ["Snow", "High Altitude", "Views", "Adventure"],
            tips: ["Book permit online 2 days in advance at rohtangpermits.nic.in", "Go early — road closes after 3 PM"],
            sfSymbol: "mountain.2.fill", gradientStart: "6C5CE7", gradientEnd: "a29bfe",
            address: "Rohtang Pass, 51 km from Manali", openHours: "Open June–October"),
        Recommendation(id: "man-s2", name: "Hadimba Temple", category: .sights,
            description: "A 16th-century cave temple dedicated to the devi Hadimba, surrounded by ancient deodar cedar forest. One of Manali's most sacred and photogenic spots.",
            priceEstimate: "Free", priceValue: 0, rating: 4.5, budgetTier: .low,
            tags: ["Temple", "Heritage", "Forest", "Photography"],
            tips: ["Visit early morning to avoid crowds", "Remove footwear outside the temple"],
            sfSymbol: "building.columns.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Hadimba Temple Road, Old Manali", openHours: "8 AM – 6 PM"),
        Recommendation(id: "man-t1", name: "Shared Tempo Traveller (Old Manali–Solang)", category: .transport,
            description: "Budget shared vehicles running fixed routes between Manali town, Old Manali, and major attractions. Best budget way to get around.",
            priceEstimate: "₹50–₹150/person", priceValue: 100, rating: 3.9, budgetTier: .low,
            tags: ["Shared", "Budget", "Local"],
            tips: ["Available from Manali Bus Stand", "Get out at the right stop — routes are fixed"],
            sfSymbol: "bus.fill", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Manali Bus Stand", openHours: "7 AM – 7 PM"),
    ]}

    // MARK: - JAIPUR
    private var jaipurRecommendations: [Recommendation] {[
        Recommendation(id: "jai-h1", name: "Zostel Jaipur", category: .hotels,
            description: "Beautifully designed heritage haveli turned backpacker hostel. Rooftop with city views, colourful Rajasthani art, and nightly cultural events.",
            priceEstimate: "₹400–₹750/night", priceValue: 550, rating: 4.4, budgetTier: .low,
            tags: ["Hostel", "Heritage", "Rooftop", "Cultural"],
            tips: ["Rooftop view of Pink City at sunset is stunning", "Join the folk music evenings"],
            sfSymbol: "house.fill", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Bani Park, Jaipur", openHours: "24/7"),
        Recommendation(id: "jai-h2", name: "Samode Haveli", category: .hotels,
            description: "A 175-year-old heritage hotel within Jaipur's walled city. Intricate frescoes, mirrored rooms, a rooftop pool, and impeccable Rajasthani hospitality.",
            priceEstimate: "₹6,000–₹14,000/night", priceValue: 9000, rating: 4.8, budgetTier: .medium,
            tags: ["Heritage", "Haveli", "Pool", "Frescoes", "Romantic"],
            tips: ["Book the Sheesh Mahal mirrored suite for the ultimate experience"],
            sfSymbol: "building.columns.fill", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Gangapole, Jaipur Walled City", openHours: "24/7"),
        Recommendation(id: "jai-h3", name: "Rambagh Palace (Taj)", category: .hotels,
            description: "The jewel of Jaipur — former palace of the Maharaja of Jaipur. Pure Rajput luxury with manicured gardens, marble interiors, and the legendary Suvarna Mahal restaurant.",
            priceEstimate: "₹25,000–₹70,000/night", priceValue: 40000, rating: 4.9, budgetTier: .high,
            tags: ["Palace Hotel", "Ultra Luxury", "Historical", "Royal"],
            tips: ["Even if not staying, visit for high tea at Suvarna Mahal", "Book garden rooms for peacock sightings"],
            sfSymbol: "star.fill", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Bhawani Singh Road, Jaipur", openHours: "24/7"),
        Recommendation(id: "jai-f1", name: "Laxmi Mishtan Bhandar (LMB)", category: .food,
            description: "Since 1954 — Jaipur's most legendary sweet shop and restaurant. Must-order: paneer ghee roast, dal baati churma, and the famous LMB special sweets.",
            priceEstimate: "₹200–₹500/person", priceValue: 350, rating: 4.5, budgetTier: .low,
            tags: ["Rajasthani Thali", "Sweets", "Historic", "Pure Veg"],
            tips: ["Try the Rajasthani thali for the complete experience", "The mithai shop downstairs is outstanding"],
            sfSymbol: "fork.knife", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Johari Bazaar, Jaipur", openHours: "8 AM – 10:30 PM"),
        Recommendation(id: "jai-s1", name: "Amber Fort", category: .sights,
            description: "The crowning jewel of Jaipur — a massive hilltop fort with intricate mirror work, elephant rides, light & sound shows, and sweeping views of the Aravalli range.",
            priceEstimate: "₹100 (Indian) / ₹500 (Foreign)", priceValue: 100, rating: 4.8, budgetTier: .low,
            tags: ["Fort", "Heritage", "Views", "UNESCO", "Elephants"],
            tips: ["Go early at 8 AM to beat crowds", "Audio guide available in Hindi & English", "L&S show at 7:30 PM"],
            sfSymbol: "building.columns.fill", gradientStart: "e17055", gradientEnd: "FDCB6E",
            address: "Devisinghpura, Amer, Jaipur", openHours: "8 AM – 5:30 PM"),
        Recommendation(id: "jai-s2", name: "Hawa Mahal", category: .sights,
            description: "Jaipur's most iconic landmark — the Palace of Winds with 953 small windows, built for royal women to observe street life. Best photographed from the tea shops opposite.",
            priceEstimate: "₹50 entry", priceValue: 50, rating: 4.5, budgetTier: .low,
            tags: ["Iconic", "Photography", "Heritage", "Architecture"],
            tips: ["Best photographed from the cafe opposite at sunrise", "Quick visit — 45 minutes is enough"],
            sfSymbol: "building.fill", gradientStart: "FDCB6E", gradientEnd: "e17055",
            address: "Hawa Mahal Road, Pink City, Jaipur", openHours: "9 AM – 5 PM"),
        Recommendation(id: "jai-t1", name: "Auto Rickshaw (City Tour)", category: .transport,
            description: "Negotiate a full-day auto-rickshaw for exploring all Pink City sights. Drivers often double as knowledgeable local guides.",
            priceEstimate: "₹600–₹1,000/day", priceValue: 800, rating: 4.1, budgetTier: .low,
            tags: ["Local", "Auto", "City Tour", "Flexible"],
            tips: ["Negotiate before starting", "Ask driver to take scenic route through Bazaars", "Fixed-price options available at railway station"],
            sfSymbol: "car.fill", gradientStart: "FDCB6E", gradientEnd: "e17055",
            address: "Available throughout Jaipur", openHours: "6 AM – 10 PM"),
    ]}

    // MARK: - KERALA
    private var keralaRecommendations: [Recommendation] {[
        Recommendation(id: "ker-h1", name: "Munnar Tea County Budget Lodge", category: .hotels,
            description: "Simple, clean rooms with sweeping tea garden views at affordable rates. Wake up to mist-covered valleys and fresh mountain air.",
            priceEstimate: "₹800–₹1,500/night", priceValue: 1100, rating: 4.1, budgetTier: .low,
            tags: ["Budget", "Tea Garden View", "Mountain", "Clean"],
            tips: ["Ask for valley-facing room", "Morning tea with views is magical"],
            sfSymbol: "house.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Munnar Town, Kerala", openHours: "24/7"),
        Recommendation(id: "ker-h2", name: "Windermere Estate", category: .hotels,
            description: "A heritage bungalow on a working tea and cardamom estate. Colonial architecture, plantation walks, and homemade estate food make this uniquely Munnar.",
            priceEstimate: "₹5,000–₹10,000/night", priceValue: 7000, rating: 4.7, budgetTier: .medium,
            tags: ["Heritage", "Plantation", "Colonial", "Romantic"],
            tips: ["Join the guided plantation walk at 7 AM", "All meals from estate-grown produce"],
            sfSymbol: "leaf.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Pothamedu, Munnar", openHours: "24/7"),
        Recommendation(id: "ker-f1", name: "Saravana Bhavan, Munnar", category: .food,
            description: "Authentic Kerala sadya served on banana leaf — rice, sambar, rasam, avial, olan, and payasam. A traditional feast experience.",
            priceEstimate: "₹100–₹200/meal", priceValue: 150, rating: 4.3, budgetTier: .low,
            tags: ["Sadya", "Banana Leaf", "Traditional", "Veg"],
            tips: ["Eat with your hand — it's tradition!", "Payasam dessert is outstanding"],
            sfSymbol: "fork.knife", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Munnar Town Centre", openHours: "7 AM – 9 PM"),
        Recommendation(id: "ker-s1", name: "Eravikulam National Park", category: .sights,
            description: "Home to the endangered Nilgiri Tahr and India's second-highest peak Anamudi. Stunning grassland plateau with trekking trails and high chances of wildlife sightings.",
            priceEstimate: "₹125 entry", priceValue: 125, rating: 4.6, budgetTier: .low,
            tags: ["Wildlife", "Trekking", "National Park", "Nilgiri Tahr"],
            tips: ["Go on weekdays to avoid crowds", "Tahr are most active in the morning", "Closed Feb–March (breeding season)"],
            sfSymbol: "binoculars.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Rajamala, Munnar, Kerala", openHours: "7:30 AM – 4 PM"),
        Recommendation(id: "ker-t1", name: "KSRTC Bus (Munnar–Alleppey)", category: .transport,
            description: "Comfortable Kerala state bus service connecting Munnar's hills to Alleppey's backwaters. Scenic journey through tea estates and rubber plantations.",
            priceEstimate: "₹200–₹400/journey", priceValue: 300, rating: 3.8, budgetTier: .low,
            tags: ["Bus", "Budget", "Scenic"],
            tips: ["Book Volvo AC bus for more comfort", "Journey takes ~4 hours — take a window seat"],
            sfSymbol: "bus.fill", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Munnar Bus Stand", openHours: "5 AM – 9 PM"),
    ]}

    // MARK: - LADAKH
    private var ladakhRecommendations: [Recommendation] {[
        Recommendation(id: "lad-h1", name: "Stok Village Guesthouse", category: .hotels,
            description: "Stay with a local Ladakhi family in a traditional mud-brick home. Experience authentic local culture, home-cooked meals, and views of Stok Kangri glacier.",
            priceEstimate: "₹700–₹1,500/night", priceValue: 1000, rating: 4.5, budgetTier: .low,
            tags: ["Homestay", "Local Culture", "Authentic", "Village"],
            tips: ["Best booked directly with village families", "Meals included in most homestays"],
            sfSymbol: "house.fill", gradientStart: "2d3436", gradientEnd: "636e72",
            address: "Stok Village, 15 km from Leh", openHours: "24/7"),
        Recommendation(id: "lad-h2", name: "The Grand Dragon Ladakh", category: .hotels,
            description: "Premium hotel with mountain views, altitude-adapted rooms, and a restaurant serving pan-Indian and continental cuisine. Excellent base for Ladakh exploration.",
            priceEstimate: "₹8,000–₹18,000/night", priceValue: 12000, rating: 4.7, budgetTier: .high,
            tags: ["Luxury", "Mountain View", "Premium", "Oxygen Bar"],
            tips: ["Request high-floor room for peak views", "Oxygen enriched rooms help with acclimatisation"],
            sfSymbol: "star.fill", gradientStart: "6C5CE7", gradientEnd: "a29bfe",
            address: "Old Leh Road, Leh", openHours: "24/7"),
        Recommendation(id: "lad-f1", name: "Bon Appetit Restaurant", category: .food,
            description: "Cozy rooftop restaurant in Leh serving traditional Ladakhi dishes like thukpa, skyu, and butter tea alongside Indian and continental options.",
            priceEstimate: "₹200–₹500/person", priceValue: 350, rating: 4.3, budgetTier: .low,
            tags: ["Ladakhi", "Thukpa", "Rooftop", "Local"],
            tips: ["Try the butter tea and tsampa for true Ladakhi experience", "Views of Leh Palace from rooftop"],
            sfSymbol: "fork.knife", gradientStart: "2d3436", gradientEnd: "636e72",
            address: "Main Bazaar Road, Leh", openHours: "7 AM – 10 PM"),
        Recommendation(id: "lad-s1", name: "Pangong Tso Lake", category: .sights,
            description: "The world-famous high-altitude salt lake at 4,350 metres, changing colours from blue to turquoise to green through the day. Made iconic by the film '3 Idiots'.",
            priceEstimate: "₹400 permit + ₹2,500 taxi", priceValue: 2900, rating: 4.9, budgetTier: .medium,
            tags: ["Lake", "High Altitude", "Photography", "Iconic"],
            tips: ["Overnight camping at Pangong recommended for sunrise", "Bring warm clothes — freezing at night even in summer"],
            sfSymbol: "water.waves", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Pangong, Ladakh (5 hours from Leh)", openHours: "Always Open"),
        Recommendation(id: "lad-t1", name: "Royal Enfield Bike Rental", category: .transport,
            description: "The ultimate Ladakh experience — rent a Royal Enfield Himalayan or Bullet and ride the legendary Manali-Leh highway. True freedom on the world's highest motorable roads.",
            priceEstimate: "₹1,200–₹2,000/day", priceValue: 1600, rating: 4.8, budgetTier: .medium,
            tags: ["Bike", "Adventure", "Royal Enfield", "Freedom"],
            tips: ["Valid driving licence mandatory", "Book well in advance in peak season (July–Aug)", "Get basic tool kit and puncture kit"],
            sfSymbol: "bicycle", gradientStart: "2d3436", gradientEnd: "636e72",
            address: "Fort Road, Leh Market", openHours: "8 AM – 6 PM"),
    ]}

    // MARK: - VARANASI
    private var varanasiRecommendations: [Recommendation] {[
        Recommendation(id: "var-h1", name: "Zostel Varanasi", category: .hotels,
            description: "Heritage building near the ghats with a rooftop overlooking the Ganges. Lively social atmosphere with travellers from around the world. Best budget spot in Varanasi.",
            priceEstimate: "₹400–₹900/night", priceValue: 600, rating: 4.4, budgetTier: .low,
            tags: ["Hostel", "Ghat View", "Heritage", "Social"],
            tips: ["Book the Ganges-view private room", "Rooftop yoga at 6 AM is included"],
            sfSymbol: "house.fill", gradientStart: "d63031", gradientEnd: "ff7675",
            address: "Assi Ghat Area, Varanasi", openHours: "24/7"),
        Recommendation(id: "var-h2", name: "BrijRama Palace", category: .hotels,
            description: "A 250-year-old palace right on the Ganges ghats, converted into a heritage hotel. Watch the Ganga Aarti from your private balcony every evening.",
            priceEstimate: "₹15,000–₹35,000/night", priceValue: 22000, rating: 4.8, budgetTier: .high,
            tags: ["Heritage Palace", "Ganges View", "Luxury", "Royal"],
            tips: ["Balcony suite for Aarti views is worth every rupee", "Book river boat rides through the hotel"],
            sfSymbol: "star.fill", gradientStart: "d63031", gradientEnd: "ff7675",
            address: "Darbhanga Ghat, Varanasi", openHours: "24/7"),
        Recommendation(id: "var-f1", name: "Deena Chat Bhandar", category: .food,
            description: "Legendary chaat stall near Dashashwamedh Ghat, running since 1925. Their tamatar chaat and kachori sabzi are Varanasi's soul food — not to be missed.",
            priceEstimate: "₹30–₹100/dish", priceValue: 60, rating: 4.7, budgetTier: .low,
            tags: ["Chaat", "Street Food", "Historic", "Local"],
            tips: ["Best at breakfast — queue starts at 7 AM", "Try the malaiyo (winter only)"],
            sfSymbol: "fork.knife", gradientStart: "d63031", gradientEnd: "ff7675",
            address: "Near Dashashwamedh Ghat, Varanasi", openHours: "6 AM – 9 PM"),
        Recommendation(id: "var-s1", name: "Ganga Aarti at Dashashwamedh Ghat", category: .sights,
            description: "India's most spectacular evening ritual — dozens of priests perform a synchronised fire ceremony on the ghats every sunset, with chanting, incense, and thousands of diyas.",
            priceEstimate: "Free (boat viewing ₹200–₹500)", priceValue: 0, rating: 4.9, budgetTier: .low,
            tags: ["Spiritual", "Free", "Cultural", "Photography", "Evening"],
            tips: ["Arrive 45 mins early for riverside spot", "Viewing from a boat is even more magical", "Happens at sunset, year-round"],
            sfSymbol: "flame.fill", gradientStart: "d63031", gradientEnd: "ff7675",
            address: "Dashashwamedh Ghat, Varanasi", openHours: "Every evening at sunset"),
        Recommendation(id: "var-t1", name: "Boat Ride on Ganges (Dawn)", category: .transport,
            description: "A sunrise rowboat ride on the Ganges past all the ghats — from the burning Manikarnika Ghat to the peaceful Assi Ghat. The most iconic Varanasi experience.",
            priceEstimate: "₹200–₹600/hour", priceValue: 400, rating: 4.8, budgetTier: .low,
            tags: ["Boat", "Sunrise", "Iconic", "Ganges"],
            tips: ["Negotiate price at Dashaswamedh Ghat jetty", "5 AM is ideal — perfectly calm water at dawn"],
            sfSymbol: "water.waves", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "All major Ghats, Varanasi", openHours: "4 AM – 8 PM"),
    ]}

    // MARK: - RISHIKESH
    private var rishikeshRecommendations: [Recommendation] {[
        Recommendation(id: "rish-h1", name: "Zostel Rishikesh", category: .hotels,
            description: "Riverside hostel on the banks of the Ganges. Wake up to the sound of flowing water, practice yoga on the banks, and meet fellow adventure seekers.",
            priceEstimate: "₹450–₹850/night", priceValue: 650, rating: 4.5, budgetTier: .low,
            tags: ["Riverside", "Yoga", "Social", "Adventure"],
            tips: ["Dorm with Ganges view — book early", "Evening satsang sessions are open to all"],
            sfSymbol: "house.fill", gradientStart: "00cec9", gradientEnd: "81ecec",
            address: "Laxman Jhula, Rishikesh", openHours: "24/7"),
        Recommendation(id: "rish-h2", name: "Ananda in the Himalayas", category: .hotels,
            description: "India's most acclaimed luxury wellness resort. Set in a maharaja's estate, with world-class Ayurvedic spa, yoga, meditation, and Himalayan views.",
            priceEstimate: "₹25,000–₹60,000/night", priceValue: 38000, rating: 4.9, budgetTier: .high,
            tags: ["Wellness", "Luxury Spa", "Ayurveda", "Royal", "Yoga"],
            tips: ["Book Ayurvedic wellness packages for best value", "3-night minimum recommended"],
            sfSymbol: "star.fill", gradientStart: "00cec9", gradientEnd: "81ecec",
            address: "Narendra Nagar, Rishikesh", openHours: "24/7"),
        Recommendation(id: "rish-f1", name: "Little Buddha Café", category: .food,
            description: "Rooftop café overlooking Lakshman Jhula bridge. Known for its fresh juices, Israeli breakfast, and organic local food — popular among yoga students and backpackers.",
            priceEstimate: "₹200–₹500/person", priceValue: 350, rating: 4.4, budgetTier: .low,
            tags: ["Rooftop", "Café", "Organic", "Views"],
            tips: ["Get there early for the best river-view tables", "Try the avocado toast + fresh pomegranate juice"],
            sfSymbol: "fork.knife", gradientStart: "00cec9", gradientEnd: "81ecec",
            address: "Lakshman Jhula, Rishikesh", openHours: "7 AM – 9 PM"),
        Recommendation(id: "rish-s1", name: "River Rafting (Grade 3–4)", category: .sights,
            description: "White-water rafting through thrilling rapids on the Ganges. Packages from 9km to 36km available, ending at Rishikesh. The most popular adventure activity in Uttarakhand.",
            priceEstimate: "₹600–₹1,800/person", priceValue: 1000, rating: 4.7, budgetTier: .low,
            tags: ["Rafting", "Adventure", "Ganges", "Adrenaline"],
            tips: ["Best during Oct–Nov and Mar–May", "Don't raft during July–August (high flood risk)", "Wear synthetic clothes — dries fast"],
            sfSymbol: "water.waves", gradientStart: "00cec9", gradientEnd: "81ecec",
            address: "Shivpuri, 16 km from Rishikesh", openHours: "8 AM – 4 PM"),
        Recommendation(id: "rish-t1", name: "Shared Jeep (Rishikesh–Haridwar)", category: .transport,
            description: "Budget shared jeeps running frequently between Rishikesh and Haridwar. Best way to combine both holy cities in one trip.",
            priceEstimate: "₹50–₹100/person", priceValue: 70, rating: 4.0, budgetTier: .low,
            tags: ["Shared Jeep", "Budget", "Frequent"],
            tips: ["Available from Rishikesh Bus Stand every 30 min", "Journey is 30 minutes"],
            sfSymbol: "car.fill", gradientStart: "0984e3", gradientEnd: "74b9ff",
            address: "Rishikesh Bus Stand", openHours: "6 AM – 9 PM"),
    ]}

    // MARK: - AGRA
    private var agraRecommendations: [Recommendation] {[
        Recommendation(id: "agr-h1", name: "Hotel Kamal", category: .hotels,
            description: "Budget hotel with a rooftop restaurant offering one of the best views of the Taj Mahal at sunrise. Clean rooms, helpful staff, and unbeatable location.",
            priceEstimate: "₹900–₹1,800/night", priceValue: 1300, rating: 4.2, budgetTier: .low,
            tags: ["Taj View", "Rooftop", "Budget", "Location"],
            tips: ["Book the rooftop sunrise breakfast — it's spectacular", "Ask for room with Taj view"],
            sfSymbol: "house.fill", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Taj Ganj, Near South Gate, Agra", openHours: "24/7"),
        Recommendation(id: "agr-h2", name: "Oberoi Amarvilas", category: .hotels,
            description: "Considered the world's best hotel for views — every room faces the Taj Mahal directly, just 600 metres away. An unmatched experience of pure Mughal-inspired luxury.",
            priceEstimate: "₹45,000–₹90,000/night", priceValue: 60000, rating: 5.0, budgetTier: .high,
            tags: ["Taj Mahal View", "Ultra Luxury", "World's Best", "Iconic"],
            tips: ["Watch the Taj change colour from your balcony at different times of day", "Book minimum 3 months ahead"],
            sfSymbol: "star.fill", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Taj East Gate Road, Agra", openHours: "24/7"),
        Recommendation(id: "agr-f1", name: "Pinch of Spice", category: .food,
            description: "Agra's most consistently rated restaurant for North Indian cuisine. Their dal makhani, biryani, and agra petha-inspired desserts are not to be missed.",
            priceEstimate: "₹500–₹1,000/person", priceValue: 700, rating: 4.5, budgetTier: .medium,
            tags: ["North Indian", "Popular", "Consistent", "Biryani"],
            tips: ["Reservation recommended for dinner", "Try the Agra special dessert platter"],
            sfSymbol: "fork.knife", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Fatehabad Road, Agra", openHours: "12 PM – 3:30 PM, 7 PM – 11 PM"),
        Recommendation(id: "agr-s1", name: "Taj Mahal", category: .sights,
            description: "The Seventh Wonder of the World and India's most iconic monument. A UNESCO World Heritage Site, it was built by Mughal Emperor Shah Jahan in memory of his beloved wife Mumtaz Mahal.",
            priceEstimate: "₹50 (Indian) / ₹1,100 (Foreign)", priceValue: 50, rating: 5.0, budgetTier: .low,
            tags: ["UNESCO", "Wonder of World", "Mughal", "Photography", "Romance"],
            tips: ["Visit at sunrise or sunset for golden light", "Buy ticket online at asi.payumoney.com to skip queues", "Fridays closed for prayers"],
            sfSymbol: "star.fill", gradientStart: "6d4c41", gradientEnd: "bcaaa4",
            address: "Dharmapuri, Forest Colony, Taj Nagri, Agra", openHours: "Sunrise to Sunset (except Friday)"),
        Recommendation(id: "agr-t1", name: "Tuk-Tuk (E-Rickshaw Tour)", category: .transport,
            description: "Eco-friendly electric rickshaws ply the main tourist circuit covering Taj Mahal, Agra Fort, and local markets. Zero-emission zone near Taj keeps the air cleaner.",
            priceEstimate: "₹100–₹300/trip", priceValue: 200, rating: 4.2, budgetTier: .low,
            tags: ["Eco-Friendly", "Local", "Budget", "Tourist Circuit"],
            tips: ["E-rickshaws are mandatory near the Taj — no petrol vehicles allowed", "Agree on price before boarding"],
            sfSymbol: "car.fill", gradientStart: "00B894", gradientEnd: "55efc4",
            address: "Available near all major sights", openHours: "6 AM – 9 PM"),
    ]}
}
