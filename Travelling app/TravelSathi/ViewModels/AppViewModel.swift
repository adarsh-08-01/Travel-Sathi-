import SwiftUI
import Combine

// MARK: - App Screen
enum AppScreen: Equatable {
    case onboarding
    case destination
    case tripPlan
    case placeDetail(Recommendation)
    case packingList
    case feedback

    static func == (lhs: AppScreen, rhs: AppScreen) -> Bool {
        switch (lhs, rhs) {
        case (.onboarding, .onboarding),
             (.destination, .destination),
             (.tripPlan, .tripPlan),
             (.packingList, .packingList),
             (.feedback, .feedback):
            return true
        case (.placeDetail(let a), .placeDetail(let b)):
            return a.id == b.id
        default:
            return false
        }
    }
}

// MARK: - App View Model
final class AppViewModel: ObservableObject {

    // MARK: Navigation
    @Published var currentScreen: AppScreen = .onboarding

    // MARK: User Data
    @Published var userProfile = UserProfile()
    @Published var selectedDestination: Destination? = nil
    @Published var currentTripPlan: TripPlan? = nil
    @Published var feedback = TripFeedback()
    @Published var feedbackSubmitted = false

    // MARK: Packing
    @Published var packingList: PackingList? = nil

    // MARK: Profile Switcher Sheet
    @Published var showProfileSwitcher = false

    // MARK: Loading
    @Published var isGeneratingPlan = false

    // MARK: Search
    @Published var searchText = ""
    @Published var filteredDestinations: [Destination] = []

    private let dataService = MockDataService.shared
    private let packingService = PackingListService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        filteredDestinations = dataService.destinations
        setupSearch()
    }

    // MARK: - Search
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.filterDestinations(text)
            }
            .store(in: &cancellables)
    }

    private func filterDestinations(_ query: String) {
        if query.isEmpty {
            filteredDestinations = dataService.destinations
        } else {
            filteredDestinations = dataService.destinations.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.state.localizedCaseInsensitiveContains(query) ||
                $0.tags.contains { $0.localizedCaseInsensitiveContains(query) }
            }
        }
    }

    // MARK: - Profile Switching (KEY NEW FEATURE)
    func switchTravelerType(to type: TravelerType) {
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        haptic.impactOccurred()

        withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
            userProfile.travelerType = type
            showProfileSwitcher = false
        }

        // Regenerate trip plan if one exists
        if selectedDestination != nil && currentScreen == .tripPlan {
            regenerateTripPlan()
        }

        // Regenerate packing list if on packing screen
        if currentScreen == .packingList, let dest = selectedDestination {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                packingList = packingService.generatePackingList(for: dest, profile: userProfile)
            }
        }
    }

    // MARK: - Navigation
    func proceedToDestination() {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
            currentScreen = .destination
        }
    }

    func selectDestination(_ destination: Destination) {
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        haptic.impactOccurred()
        selectedDestination = destination
        generateTripPlan()
    }

    func viewPlaceDetail(_ recommendation: Recommendation) {
        withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) {
            currentScreen = .placeDetail(recommendation)
        }
    }

    func backFromDetail() {
        withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) {
            currentScreen = .tripPlan
        }
    }

    func openPackingList() {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        if let dest = selectedDestination {
            packingList = packingService.generatePackingList(for: dest, profile: userProfile)
        }
        withAnimation(.spring(response: 0.42, dampingFraction: 0.8)) {
            currentScreen = .packingList
        }
    }

    func backFromPackingList() {
        withAnimation(.spring(response: 0.42, dampingFraction: 0.8)) {
            currentScreen = .tripPlan
        }
    }

    func togglePackItem(id: String) {
        guard let idx = packingList?.items.firstIndex(where: { $0.id == id }) else { return }
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
            packingList?.items[idx].isPacked.toggle()
        }
    }

    func proceedToFeedback() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
            feedback = TripFeedback()
            currentScreen = .feedback
        }
    }

    func submitFeedback() {
        let haptic = UINotificationFeedbackGenerator()
        haptic.notificationOccurred(.success)
        withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
            feedbackSubmitted = true
        }
    }

    func startNewTrip() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
            selectedDestination = nil
            currentTripPlan = nil
            packingList = nil
            feedbackSubmitted = false
            feedback = TripFeedback()
            searchText = ""
            filteredDestinations = dataService.destinations
            currentScreen = .destination
        }
    }

    func restartJourney() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
            selectedDestination = nil
            currentTripPlan = nil
            packingList = nil
            feedbackSubmitted = false
            feedback = TripFeedback()
            searchText = ""
            filteredDestinations = dataService.destinations
            userProfile = UserProfile()
            currentScreen = .onboarding
        }
    }

    // MARK: - Trip Plan Generation
    private func generateTripPlan() {
        guard let destination = selectedDestination else { return }
        withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
            isGeneratingPlan = true
            currentTripPlan = nil
            currentScreen = .tripPlan
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) { [weak self] in
            guard let self = self else { return }
            self.currentTripPlan = self.dataService.generateTripPlan(
                destination: destination,
                profile: self.userProfile
            )
            withAnimation(.spring(response: 0.55, dampingFraction: 0.78)) {
                self.isGeneratingPlan = false
            }
        }
    }

    private func regenerateTripPlan() {
        guard let destination = selectedDestination else { return }
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            isGeneratingPlan = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [weak self] in
            guard let self = self else { return }
            self.currentTripPlan = self.dataService.generateTripPlan(
                destination: destination,
                profile: self.userProfile
            )
            withAnimation(.spring(response: 0.55, dampingFraction: 0.78)) {
                self.isGeneratingPlan = false
            }
        }
    }
}
