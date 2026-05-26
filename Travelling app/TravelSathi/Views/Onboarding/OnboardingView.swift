import SwiftUI

// MARK: - Onboarding View
struct OnboardingView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var showContent = false
    @State private var nameFieldFocused = false
    @FocusState private var isNameFocused: Bool

    var body: some View {
        ZStack {
            GlowingBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    headerSection
                        .padding(.top, 60)

                    nameSection

                    travelerTypeSection

                    budgetSection

                    ctaSection
                        .padding(.bottom, 50)
                }
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.1)) {
                showContent = true
            }
        }
    }

    // MARK: Header
    private var headerSection: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(AppColors.gradientPrimary)
                    .frame(width: 90, height: 90)
                    .shadow(color: Color(hex: "6C5CE7").opacity(0.5), radius: 20, y: 8)

                Image(systemName: "airplane.departure")
                    .font(.system(size: 38, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .scaleEffect(showContent ? 1 : 0.4)
            .opacity(showContent ? 1 : 0)

            VStack(spacing: 6) {
                Text("Travel Sathi")
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [AppColors.primaryLight, Color(hex: "74b9ff")],
                            startPoint: .leading, endPoint: .trailing
                        )
                    )

                Text("Your Personal Travel Budget Guide")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 20)
        }
    }

    // MARK: Name Section
    private var nameSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Label("What's your name?", systemImage: "person.fill")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)

                TextField("Enter your name", text: $appVM.userProfile.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .focused($isNameFocused)
                    .submitLabel(.done)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(AppColors.backgroundSurface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .strokeBorder(
                                        isNameFocused ? AppColors.primary : Color.white.opacity(0.08),
                                        lineWidth: 1.5
                                    )
                            )
                    )
            }
            .padding(20)
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.15), value: showContent)
    }

    // MARK: Traveler Type Section
    private var travelerTypeSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Who are you?", systemImage: "figure.stand")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.horizontal, 4)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(TravelerType.allCases) { type in
                    TravelerTypeCard(
                        type: type,
                        isSelected: appVM.userProfile.travelerType == type
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            appVM.userProfile.travelerType = type
                        }
                    }
                }
            }
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.25), value: showContent)
    }

    // MARK: Budget Section
    private var budgetSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Set your budget", systemImage: "indianrupeesign.circle.fill")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppColors.textPrimary)
                .padding(.horizontal, 4)

            GlassCard {
                VStack(spacing: 16) {
                    HStack(spacing: 10) {
                        ForEach(BudgetTier.allCases) { tier in
                            BudgetTierButton(
                                tier: tier,
                                isSelected: appVM.userProfile.budgetTier == tier
                            ) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    appVM.userProfile.budgetTier = tier
                                    appVM.userProfile.customBudget = nil
                                }
                            }
                        }
                    }

                    Divider().background(Color.white.opacity(0.1))

                    // Range display
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Budget Range")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(AppColors.textTertiary)
                            Text(appVM.userProfile.budgetTier.range)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(Color(hex: appVM.userProfile.budgetTier.colorHex))
                        }
                        Spacer()
                        Text(appVM.userProfile.budgetTier.emoji)
                            .font(.system(size: 32))
                    }
                    .animation(.spring(response: 0.3), value: appVM.userProfile.budgetTier)
                }
                .padding(20)
            }
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.35), value: showContent)
    }

    // MARK: CTA Section
    private var ctaSection: some View {
        VStack(spacing: 16) {
            if !appVM.userProfile.name.isEmpty {
                Text("Ready, \(appVM.userProfile.name)! 🌏")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
                    .transition(.opacity.combined(with: .scale))
            }

            PrimaryButton(
                "Start My Journey",
                icon: "arrow.right.circle.fill",
                isDisabled: !appVM.userProfile.isComplete
            ) {
                appVM.proceedToDestination()
            }
        }
        .opacity(showContent ? 1 : 0)
        .animation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.45), value: showContent)
    }
}

// MARK: - Traveler Type Card
struct TravelerTypeCard: View {
    let type: TravelerType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(type.emoji)
                    .font(.system(size: 32))

                Text(type.rawValue)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                Text(type.tagline)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(isSelected ? .white.opacity(0.8) : AppColors.textTertiary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: type.primaryColor), Color(hex: type.primaryColor).opacity(0.7)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                )
                            )
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                    } else {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(AppColors.backgroundCard.opacity(0.8))
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
                    }
                }
            )
            .shadow(
                color: isSelected ? Color(hex: type.primaryColor).opacity(0.4) : .clear,
                radius: 10, y: 4
            )
            .scaleEffect(isSelected ? 1.03 : 1.0)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Budget Tier Button
struct BudgetTierButton: View {
    let tier: BudgetTier
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(tier.emoji)
                    .font(.system(size: 22))
                Text(tier.label)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : AppColors.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: tier.colorHex), Color(hex: tier.colorHex).opacity(0.6)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                )
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(AppColors.backgroundSurface)
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(
                        isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.06),
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}
