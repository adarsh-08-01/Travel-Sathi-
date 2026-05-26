import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appVM: AppViewModel

    var body: some View {
        ZStack {
            AppColors.backgroundDeep.ignoresSafeArea()

            Group {
                switch appVM.currentScreen {
                case .onboarding:
                    OnboardingView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))

                case .destination:
                    DestinationSearchView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))

                case .tripPlan:
                    TripPlanView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))

                case .packingList:
                    PackingListView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        ))

                case .placeDetail(let rec):
                    PlaceDetailView(recommendation: rec)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        ))

                case .feedback:
                    FeedbackView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                }
            }
            .animation(.spring(response: 0.45, dampingFraction: 0.82), value: appVM.currentScreen)

            // Profile Switcher Sheet — overlaid globally so it works from any screen
            if appVM.showProfileSwitcher {
                ProfileSwitcherSheet()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(100)
            }
        }
        .animation(.spring(response: 0.42, dampingFraction: 0.8), value: appVM.showProfileSwitcher)
    }
}
