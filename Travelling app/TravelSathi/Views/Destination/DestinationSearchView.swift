import SwiftUI

// MARK: - Destination Search View
struct DestinationSearchView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var showContent = false
    @FocusState private var isSearchFocused: Bool

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            GlowingBackground(
                primaryColor: Color(hex: "0984e3"),
                secondaryColor: Color(hex: "6C5CE7")
            )

            VStack(spacing: 0) {
                // Header
                headerBar
                    .padding(.top, 56)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                // Search Bar
                searchBar
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                // Content
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        if appVM.searchText.isEmpty {
                            popularDestinationsSection
                        } else {
                            searchResultsSection
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.1)) {
                showContent = true
            }
        }
    }

    // MARK: Header Bar
    private var headerBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Hello, \(appVM.userProfile.name.isEmpty ? "Traveler" : appVM.userProfile.name)! 👋")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)

                Text("Where to next?")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
            }

            Spacer()

            // Tappable profile pill — opens profile switcher
            ProfilePillButton()
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : -20)
        .animation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.05), value: showContent)
    }

    // MARK: Search Bar
    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(isSearchFocused ? AppColors.primary : AppColors.textTertiary)

            TextField("Search destinations...", text: $appVM.searchText)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(AppColors.textPrimary)
                .focused($isSearchFocused)

            if !appVM.searchText.isEmpty {
                Button {
                    withAnimation { appVM.searchText = "" }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppColors.textTertiary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(AppColors.backgroundCard.opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(
                            isSearchFocused ? AppColors.primary : Color.white.opacity(0.1),
                            lineWidth: 1.5
                        )
                )
        )
        .shadow(color: AppColors.backgroundDeep.opacity(0.5), radius: 8, y: 4)
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 20)
        .animation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.15), value: showContent)
    }

    // MARK: Popular Destinations
    private var popularDestinationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("✨ Popular Destinations")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)
                Spacer()
                Text("\(appVM.filteredDestinations.count) places")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(AppColors.textTertiary)
            }

            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(Array(appVM.filteredDestinations.enumerated()), id: \.element.id) { index, dest in
                    DestinationCard(destination: dest, index: index)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                appVM.selectDestination(dest)
                            }
                        }
                }
            }
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.25), value: showContent)
    }

    // MARK: Search Results
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(appVM.filteredDestinations.count) result\(appVM.filteredDestinations.count == 1 ? "" : "s") for '\(appVM.searchText)'")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            if appVM.filteredDestinations.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundStyle(AppColors.textTertiary)
                    Text("No destinations found")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)
                    Text("Try searching for Goa, Manali, or Jaipur")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColors.textTertiary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
            } else {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(Array(appVM.filteredDestinations.enumerated()), id: \.element.id) { index, dest in
                        DestinationCard(destination: dest, index: index)
                            .onTapGesture {
                                appVM.selectDestination(dest)
                            }
                    }
                }
            }
        }
    }
}

// MARK: - Destination Card
struct DestinationCard: View {
    let destination: Destination
    let index: Int
    @State private var appear = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Gradient background
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: destination.gradientStart),
                            Color(hex: destination.gradientEnd)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 160)

            // Pattern overlay
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.black.opacity(0.25))
                .frame(height: 160)

            // Icon (top right)
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: destination.sfSymbol)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.3))
                        .padding(14)
                }
                Spacer()
            }
            .frame(height: 160)

            // Content
            VStack(alignment: .leading, spacing: 3) {
                // Tags
                if let firstTag = destination.tags.first {
                    Text(firstTag)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                }

                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)

                Text(destination.state)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .padding(14)
        }
        .frame(height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(hex: destination.gradientStart).opacity(0.4), radius: 12, y: 6)
        .scaleEffect(appear ? 1 : 0.85)
        .opacity(appear ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.75).delay(Double(index) * 0.06)) {
                appear = true
            }
        }
    }
}
