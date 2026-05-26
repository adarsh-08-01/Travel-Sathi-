import SwiftUI

// MARK: - Feedback View
struct FeedbackView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var showContent = false

    var body: some View {
        ZStack {
            GlowingBackground(
                primaryColor: Color(hex: "FDCB6E"),
                secondaryColor: Color(hex: "e17055")
            )

            if appVM.feedbackSubmitted {
                thankYouView
            } else {
                feedbackContent
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.1)) {
                showContent = true
            }
        }
    }

    // MARK: Feedback Form
    private var feedbackContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                // Header
                feedbackHeader
                    .padding(.top, 60)

                // Star Rating
                ratingSection

                // Mood selector
                moodSection

                // Notes
                notesSection

                // Would recommend?
                recommendSection

                // Submit button
                submitSection
                    .padding(.bottom, 50)
            }
            .padding(.horizontal, 24)
        }
    }

    // MARK: Header
    private var feedbackHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(AppColors.gradientAccent)
                    .frame(width: 80, height: 80)
                    .shadow(color: Color(hex: "FDCB6E").opacity(0.4), radius: 16, y: 6)

                Image(systemName: "star.bubble.fill")
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .scaleEffect(showContent ? 1 : 0.4)
            .opacity(showContent ? 1 : 0)

            VStack(spacing: 6) {
                Text("How was your trip?")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                if let dest = appVM.selectedDestination {
                    Text("Share your \(dest.name) experience")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 20)
        }
        .animation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.1), value: showContent)
    }

    // MARK: Rating Section
    private var ratingSection: some View {
        GlassCard {
            VStack(spacing: 16) {
                Text("Overall Rating")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)

                StarRatingView(rating: $appVM.feedback.rating, starSize: 42)

                if appVM.feedback.rating > 0 {
                    Text(ratingLabel(appVM.feedback.rating))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "FDCB6E"))
                        .transition(.opacity.combined(with: .scale))
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity)
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: showContent)
    }

    private func ratingLabel(_ rating: Int) -> String {
        switch rating {
        case 1: return "😞 Disappointed"
        case 2: return "😐 Could be better"
        case 3: return "🙂 It was okay"
        case 4: return "😊 Really enjoyed it!"
        case 5: return "🤩 Absolutely amazing!"
        default: return ""
        }
    }

    // MARK: Mood Section
    private var moodSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("How do you feel?")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)

            HStack(spacing: 10) {
                ForEach(TripMood.allCases) { mood in
                    MoodButton(
                        mood: mood,
                        isSelected: appVM.feedback.mood == mood
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            appVM.feedback.mood = mood
                        }
                    }
                }
            }
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.28), value: showContent)
    }

    // MARK: Notes Section
    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Your Notes (Optional)", systemImage: "pencil.and.list.clipboard")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(AppColors.backgroundCard.opacity(0.85))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .frame(minHeight: 120)

                TextEditor(text: $appVM.feedback.notes)
                    .font(.system(size: 15))
                    .foregroundStyle(AppColors.textPrimary)
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .frame(minHeight: 120)
                    .padding(12)

                if appVM.feedback.notes.isEmpty {
                    Text("Share what you loved, what could be improved...")
                        .font(.system(size: 15))
                        .foregroundStyle(AppColors.textTertiary)
                        .padding(16)
                        .allowsHitTesting(false)
                }
            }
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.35), value: showContent)
    }

    // MARK: Recommend Section
    private var recommendSection: some View {
        GlassCard(cornerRadius: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Would you recommend this trip?")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)
                    Text("Help fellow travelers plan better")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(AppColors.textTertiary)
                }

                Spacer()

                Toggle("", isOn: $appVM.feedback.wouldRecommend)
                    .tint(AppColors.secondary)
            }
            .padding(18)
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 30)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.42), value: showContent)
    }

    // MARK: Submit Section
    private var submitSection: some View {
        VStack(spacing: 12) {
            PrimaryButton(
                "Submit Feedback",
                icon: "paperplane.fill",
                gradient: AppColors.gradientAccent,
                isDisabled: !appVM.feedback.isValid
            ) {
                appVM.submitFeedback()
            }

            Button {
                appVM.proceedToFeedback() // skip
                appVM.startNewTrip()
            } label: {
                Text("Skip for now")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.textTertiary)
            }
        }
        .opacity(showContent ? 1 : 0)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5), value: showContent)
    }

    // MARK: Thank You View
    private var thankYouView: some View {
        VStack(spacing: 32) {
            Spacer()

            // Animated checkmark
            ZStack {
                Circle()
                    .fill(AppColors.gradientSecondary)
                    .frame(width: 120, height: 120)
                    .shadow(color: AppColors.secondary.opacity(0.5), radius: 24, y: 8)

                Image(systemName: "checkmark")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundStyle(.white)
            }
            .scaleEffect(appVM.feedbackSubmitted ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.6).delay(0.1), value: appVM.feedbackSubmitted)

            VStack(spacing: 10) {
                Text("Thank You! 🙏")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text("Your feedback helps us improve\nrecommendations for every traveler.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
            }
            .opacity(appVM.feedbackSubmitted ? 1 : 0)
            .offset(y: appVM.feedbackSubmitted ? 0 : 20)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.3), value: appVM.feedbackSubmitted)

            // Stats card
            GlassCard(cornerRadius: 20) {
                HStack(spacing: 0) {
                    feedbackStat(label: "Rating", value: "\(appVM.feedback.rating)/5 ⭐")
                    Divider().background(Color.white.opacity(0.1)).frame(height: 40)
                    feedbackStat(label: "Mood", value: appVM.feedback.mood.emoji + " " + appVM.feedback.mood.rawValue)
                    Divider().background(Color.white.opacity(0.1)).frame(height: 40)
                    feedbackStat(label: "Recommend", value: appVM.feedback.wouldRecommend ? "Yes 👍" : "No 👎")
                }
                .padding(.vertical, 16)
            }
            .padding(.horizontal, 32)
            .opacity(appVM.feedbackSubmitted ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5), value: appVM.feedbackSubmitted)

            VStack(spacing: 14) {
                PrimaryButton("Plan Another Trip", icon: "map.fill", gradient: AppColors.gradientPrimary) {
                    appVM.startNewTrip()
                }

                Button {
                    appVM.restartJourney()
                } label: {
                    Text("Back to Home")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
            .padding(.horizontal, 32)
            .opacity(appVM.feedbackSubmitted ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.65), value: appVM.feedbackSubmitted)

            Spacer()
        }
    }

    private func feedbackStat(label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(AppColors.textTertiary)
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Mood Button
struct MoodButton: View {
    let mood: TripMood
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(mood.emoji)
                    .font(.system(size: 28))
                    .scaleEffect(isSelected ? 1.15 : 1.0)

                Text(mood.rawValue)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(isSelected ? Color(hex: mood.colorHex) : AppColors.textTertiary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(hex: mood.colorHex).opacity(0.15))
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(Color(hex: mood.colorHex).opacity(0.5), lineWidth: 1.5)
                    } else {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(AppColors.backgroundCard.opacity(0.7))
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.07), lineWidth: 1)
                    }
                }
            )
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
