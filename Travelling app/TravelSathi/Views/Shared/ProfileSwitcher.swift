import SwiftUI

// MARK: - Profile Switcher Sheet
/// Full-screen dimmed sheet that slides up to let user change traveler type from any screen
struct ProfileSwitcherSheet: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            // Dimmed backdrop
            Color.black.opacity(0.55)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.82)) {
                        appVM.showProfileSwitcher = false
                    }
                }

            // Sheet Panel
            VStack(spacing: 0) {
                // Drag handle
                Capsule()
                    .fill(Color.white.opacity(0.25))
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                // Header
                VStack(spacing: 6) {
                    Text("Switch Traveler Profile")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)

                    Text("Your recommendations update instantly")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppColors.textTertiary)
                }
                .padding(.bottom, 24)

                // Type Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(TravelerType.allCases) { type in
                        SwitcherTypeCard(
                            type: type,
                            isSelected: appVM.userProfile.travelerType == type
                        ) {
                            appVM.switchTravelerType(to: type)
                        }
                    }
                }
                .padding(.horizontal, 20)

                // Budget Quick-Switch
                VStack(alignment: .leading, spacing: 12) {
                    Label("Quick Budget Change", systemImage: "indianrupeesign.circle.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)
                        .padding(.top, 20)

                    HStack(spacing: 10) {
                        ForEach(BudgetTier.allCases) { tier in
                            BudgetQuickButton(
                                tier: tier,
                                isSelected: appVM.userProfile.budgetTier == tier
                            ) {
                                let haptic = UIImpactFeedbackGenerator(style: .light)
                                haptic.impactOccurred()
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    appVM.userProfile.budgetTier = tier
                                }
                                if appVM.selectedDestination != nil && appVM.currentScreen == .tripPlan {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        appVM.showProfileSwitcher = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            appVM.selectDestination(appVM.selectedDestination!)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                // Done button
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        appVM.showProfileSwitcher = false
                    }
                } label: {
                    Text("Done")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
                .padding(.top, 12)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(AppColors.backgroundCard)
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
                }
                .ignoresSafeArea(edges: .bottom)
            )
            .offset(y: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { val in
                        if val.translation.height > 0 {
                            dragOffset = val.translation.height
                        }
                    }
                    .onEnded { val in
                        if val.translation.height > 100 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                appVM.showProfileSwitcher = false
                            }
                        } else {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                dragOffset = 0
                            }
                        }
                    }
            )
        }
        .ignoresSafeArea()
    }
}

// MARK: - Switcher Type Card
struct SwitcherTypeCard: View {
    let type: TravelerType
    let isSelected: Bool
    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(type.emoji)
                    .font(.system(size: 26))
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(Color(hex: type.primaryColor).opacity(isSelected ? 0.25 : 0.12))
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(type.rawValue)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(isSelected ? Color(hex: type.primaryColor) : AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Text(type.tagline)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(AppColors.textTertiary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(hex: type.primaryColor))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(isSelected
                              ? Color(hex: type.primaryColor).opacity(0.12)
                              : AppColors.backgroundSurface)
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(
                            isSelected ? Color(hex: type.primaryColor).opacity(0.5) : Color.white.opacity(0.07),
                            lineWidth: isSelected ? 1.5 : 1
                        )
                }
            )
            .scaleEffect(pressed ? 0.96 : 1.0)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in withAnimation(.easeInOut(duration: 0.1)) { pressed = true } }
                .onEnded { _ in withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) { pressed = false } }
        )
    }
}

// MARK: - Budget Quick Button
struct BudgetQuickButton: View {
    let tier: BudgetTier
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Text(tier.emoji)
                    .font(.system(size: 20))
                Text(tier.label)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(isSelected ? Color(hex: tier.colorHex) : AppColors.textPrimary)
                Text(tier.range)
                    .font(.system(size: 9, weight: .regular))
                    .foregroundStyle(AppColors.textTertiary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(isSelected
                              ? Color(hex: tier.colorHex).opacity(0.15)
                              : AppColors.backgroundSurface)
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(
                            isSelected ? Color(hex: tier.colorHex).opacity(0.6) : Color.white.opacity(0.06),
                            lineWidth: 1.5
                        )
                }
            )
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

// MARK: - Profile Pill Button
/// Reusable pill that opens the profile switcher from any screen header
struct ProfilePillButton: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var bounce = false

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                appVM.showProfileSwitcher = true
                bounce = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { bounce = false }
        } label: {
            HStack(spacing: 6) {
                Text(appVM.userProfile.travelerType.emoji)
                    .font(.system(size: 18))

                VStack(alignment: .leading, spacing: 1) {
                    Text(appVM.userProfile.travelerType.rawValue)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 8, weight: .semibold))
                        Text("Switch")
                            .font(.system(size: 9, weight: .medium))
                    }
                    .foregroundStyle(.white.opacity(0.65))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color(hex: appVM.userProfile.travelerType.primaryColor).opacity(0.3))
                    .overlay(
                        Capsule()
                            .strokeBorder(Color(hex: appVM.userProfile.travelerType.primaryColor).opacity(0.5), lineWidth: 1)
                    )
            )
        }
        .scaleEffect(bounce ? 1.06 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: bounce)
        .buttonStyle(.plain)
    }
}
