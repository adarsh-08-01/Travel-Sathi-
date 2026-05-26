import SwiftUI

// MARK: - Trip Plan View
struct TripPlanView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var selectedCategory: RecommendationCategory = .hotels
    @State private var showContent = false

    var body: some View {
        ZStack {
            GlowingBackground(
                primaryColor: Color(hex: "00B894"),
                secondaryColor: Color(hex: "6C5CE7")
            )

            if appVM.isGeneratingPlan {
                loadingView
            } else {
                planContent
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.2)) {
                showContent = true
            }
        }
    }

    // MARK: Loading View
    private var loadingView: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                Circle()
                    .fill(AppColors.gradientPrimary)
                    .frame(width: 100, height: 100)
                    .shadow(color: AppColors.primary.opacity(0.5), radius: 20)

                Image(systemName: "sparkles")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .rotationEffect(.degrees(appVM.isGeneratingPlan ? 360 : 0))
            .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: appVM.isGeneratingPlan)

            VStack(spacing: 10) {
                Text("Building Your Trip Plan")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                if let dest = appVM.selectedDestination {
                    Text("Personalizing for \(dest.name) based on your \(appVM.userProfile.budgetTier.label) budget...")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
            }

            LoadingDotsView()

            Spacer()
        }
    }

    // MARK: Plan Content
    private var planContent: some View {
        VStack(spacing: 0) {
            // Header
            planHeader
                .padding(.top, 56)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)

            // Budget Summary
            if let plan = appVM.currentTripPlan {
                budgetSummaryCard(plan: plan)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 14)
            }

            // Category Tabs
            categoryTabBar
                .padding(.horizontal, 24)
                .padding(.bottom, 14)

            // Recommendations
            recommendationsList
        }
    }

    // MARK: Plan Header
    private var planHeader: some View {
        HStack(alignment: .center) {
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    appVM.currentScreen = .destination
                }
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .frame(width: 40, height: 40)
                    .background(AppColors.backgroundCard.opacity(0.8))
                    .clipShape(Circle())
            }

            Spacer()

            VStack(spacing: 3) {
                if let dest = appVM.selectedDestination {
                    Text(dest.name)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                    Text(dest.state + " · " + (appVM.currentTripPlan?.tripDuration ?? ""))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                }
            }

            Spacer()

            // Tappable profile pill — opens switcher
            ProfilePillButton()
        }
        .opacity(showContent ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.05), value: showContent)
    }

    // MARK: Budget Summary Card
    private func budgetSummaryCard(plan: TripPlan) -> some View {
        GlassCard(cornerRadius: 18) {
            HStack(spacing: 0) {
                budgetStat(label: "Stay", value: plan.budgetBreakdown.accommodation)
                Divider().background(Color.white.opacity(0.1)).frame(height: 40)
                budgetStat(label: "Food", value: plan.budgetBreakdown.food)
                Divider().background(Color.white.opacity(0.1)).frame(height: 40)
                budgetStat(label: "Total", value: plan.budgetBreakdown.total, isHighlighted: true)
            }
            .padding(.vertical, 14)
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 20)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.15), value: showContent)
    }

    private func budgetStat(label: String, value: String, isHighlighted: Bool = false) -> some View {
        VStack(spacing: 3) {
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(AppColors.textTertiary)
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(isHighlighted ? Color(hex: appVM.userProfile.budgetTier.colorHex) : AppColors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: Category Tab Bar
    private var categoryTabBar: some View {
        HStack(spacing: 8) {
            ForEach(RecommendationCategory.allCases) { cat in
                CategoryTab(
                    category: cat,
                    isSelected: selectedCategory == cat,
                    count: appVM.currentTripPlan?.recommendations(for: cat).count ?? 0
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedCategory = cat
                    }
                }
            }
        }
        .opacity(showContent ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.2), value: showContent)
    }

    // MARK: Recommendations List
    private var recommendationsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 14) {
                let recs = appVM.currentTripPlan?.recommendations(for: selectedCategory) ?? []

                if recs.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: selectedCategory.sfSymbol)
                            .font(.system(size: 44))
                            .foregroundStyle(AppColors.textTertiary)
                        Text("No \(selectedCategory.rawValue) in this budget")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(AppColors.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                } else {
                    ForEach(Array(recs.enumerated()), id: \.element.id) { index, rec in
                        RecommendationCard(recommendation: rec, index: index)
                            .onTapGesture {
                                appVM.viewPlaceDetail(rec)
                            }
                            .padding(.horizontal, 24)
                    }
                }

                // Action Buttons at bottom
                if !appVM.isGeneratingPlan {
                    VStack(spacing: 10) {
                        // Pack Button — PRIMARY new feature
                        Button {
                            appVM.openPackingList()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "bag.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Pack Smart 🎒")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                BadgeView(text: "NEW", colorHex: "00B894")
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .frame(height: 54)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "00B894"), Color(hex: "55efc4")],
                                    startPoint: .leading, endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(hex: "00B894").opacity(0.35), radius: 12, y: 5)
                        }
                        .buttonStyle(.plain)

                        PrimaryButton(
                            "Rate This Trip Plan",
                            icon: "star.fill",
                            gradient: AppColors.gradientAccent
                        ) {
                            appVM.proceedToFeedback()
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 50)
                }

            }
            .padding(.top, 4)
        }
        .opacity(showContent ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.3), value: showContent)
    }
}

// MARK: - Category Tab
struct CategoryTab: View {
    let category: RecommendationCategory
    let isSelected: Bool
    let count: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(category.emoji)
                    .font(.system(size: 18))
                Text(category.rawValue)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: category.colorHex), Color(hex: category.colorHex).opacity(0.7)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                )
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(AppColors.backgroundCard.opacity(0.8))
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(Color.white.opacity(isSelected ? 0.2 : 0.07), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Recommendation Card
struct RecommendationCard: View {
    let recommendation: Recommendation
    let index: Int
    @State private var appear = false

    var body: some View {
        GlassCard(cornerRadius: 18) {
            VStack(alignment: .leading, spacing: 0) {
                // Gradient header
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(hex: recommendation.gradientStart),
                                    Color(hex: recommendation.gradientEnd)
                                ],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.black.opacity(0.2))
                        )

                    HStack {
                        Image(systemName: recommendation.sfSymbol)
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.85))
                            .padding(14)
                        Spacer()
                        // Budget badge
                        BadgeView(
                            text: recommendation.budgetFitLabel,
                            colorHex: recommendation.budgetTier.colorHex
                        )
                        .padding(12)
                    }
                }

                // Content
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(recommendation.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(AppColors.textPrimary)

                            RatingStarsView(rating: recommendation.rating)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 3) {
                            Text(recommendation.priceEstimate)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(Color(hex: recommendation.category.colorHex))
                        }
                    }

                    Text(recommendation.description)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(2)

                    // Tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(recommendation.tags.prefix(3), id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(AppColors.textTertiary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(AppColors.backgroundSurface)
                                    .clipShape(Capsule())
                            }
                        }
                    }

                    // Tap indicator
                    HStack {
                        Spacer()
                        HStack(spacing: 4) {
                            Text("View details")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color(hex: recommendation.category.colorHex))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Color(hex: recommendation.category.colorHex))
                        }
                    }
                }
                .padding(14)
            }
        }
        .scaleEffect(appear ? 1 : 0.9)
        .opacity(appear ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.75).delay(Double(index) * 0.08)) {
                appear = true
            }
        }
    }
}
