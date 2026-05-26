import SwiftUI

// MARK: - Place Detail View
struct PlaceDetailView: View {
    @EnvironmentObject var appVM: AppViewModel
    let recommendation: Recommendation
    @State private var showContent = false
    @State private var addedToItinerary = false

    var body: some View {
        ZStack {
            AppColors.backgroundDeep.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Hero Section
                    heroSection

                    // Content
                    VStack(alignment: .leading, spacing: 24) {
                        metaInfoSection
                        descriptionSection
                        tipsSection
                        practicalInfoSection
                        ctaSection
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 50)
                }
            }
            .ignoresSafeArea(edges: .top)

            // Back Button (floating)
            VStack {
                HStack {
                    Button {
                        appVM.backFromDetail()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 42, height: 42)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
                    }
                    .padding(.leading, 24)
                    .padding(.top, 56)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                showContent = true
            }
        }
    }

    // MARK: Hero Section
    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            // Gradient background
            LinearGradient(
                colors: [
                    Color(hex: recommendation.gradientStart),
                    Color(hex: recommendation.gradientEnd)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 300)

            // Overlay
            LinearGradient(
                colors: [.clear, AppColors.backgroundDeep],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 300)

            // Large icon
            HStack {
                Spacer()
                Image(systemName: recommendation.sfSymbol)
                    .font(.system(size: 100, weight: .thin))
                    .foregroundStyle(.white.opacity(0.12))
                    .padding(.bottom, 80)
                    .padding(.trailing, 30)
            }

            // Bottom content
            VStack(alignment: .leading, spacing: 6) {
                // Category badge
                HStack(spacing: 6) {
                    Text(recommendation.category.emoji)
                    Text(recommendation.category.rawValue)
                        .font(.system(size: 12, weight: .semibold))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(hex: recommendation.category.colorHex).opacity(0.25))
                .overlay(
                    Capsule().strokeBorder(Color(hex: recommendation.category.colorHex).opacity(0.4), lineWidth: 1)
                )
                .clipShape(Capsule())
                .foregroundStyle(Color(hex: recommendation.category.colorHex))

                Text(recommendation.name)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                HStack(spacing: 12) {
                    RatingStarsView(rating: recommendation.rating)

                    Spacer()

                    BadgeView(text: recommendation.budgetFitLabel, colorHex: recommendation.budgetTier.colorHex)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .frame(height: 300)
    }

    // MARK: Meta Info
    private var metaInfoSection: some View {
        HStack(spacing: 12) {
            metaCard(icon: "indianrupeesign.circle.fill", label: "Price", value: recommendation.priceEstimate, colorHex: recommendation.category.colorHex)
            metaCard(icon: "clock.fill", label: "Hours", value: recommendation.openHours, colorHex: "a29bfe")
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.1), value: showContent)
    }

    private func metaCard(icon: String, label: String, value: String, colorHex: String) -> some View {
        GlassCard(cornerRadius: 14) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Image(systemName: icon)
                        .font(.system(size: 13))
                        .foregroundStyle(Color(hex: colorHex))
                    Text(label)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppColors.textTertiary)
                }
                Text(value)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: Description
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("About", systemImage: "info.circle.fill")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)

            Text(recommendation.description)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(5)
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.15), value: showContent)
    }

    // MARK: Tips
    private var tipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Travel Tips", systemImage: "lightbulb.fill")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)

            VStack(spacing: 10) {
                ForEach(Array(recommendation.tips.enumerated()), id: \.offset) { _, tip in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(Color(hex: recommendation.category.colorHex))
                            .frame(width: 6, height: 6)
                            .padding(.top, 7)

                        Text(tip)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(4)

                        Spacer()
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(hex: recommendation.category.colorHex).opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(Color(hex: recommendation.category.colorHex).opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.2), value: showContent)
    }

    // MARK: Practical Info
    private var practicalInfoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Location", systemImage: "location.fill")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppColors.textPrimary)

            GlassCard(cornerRadius: 14) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: recommendation.category.colorHex).opacity(0.15))
                            .frame(width: 44, height: 44)
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(Color(hex: recommendation.category.colorHex))
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(recommendation.address)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(AppColors.textPrimary)
                        Text("Tap to open in Maps")
                            .font(.system(size: 12))
                            .foregroundStyle(AppColors.textTertiary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColors.textTertiary)
                }
                .padding(14)
            }
        }
        .opacity(showContent ? 1 : 0)
        .offset(y: showContent ? 0 : 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.25), value: showContent)
    }

    // MARK: CTA
    private var ctaSection: some View {
        VStack(spacing: 12) {
            PrimaryButton(
                addedToItinerary ? "Added to Itinerary ✓" : "Add to Itinerary",
                icon: addedToItinerary ? "checkmark.circle.fill" : "plus.circle.fill",
                gradient: addedToItinerary ? AppColors.gradientSecondary : AppColors.gradientPrimary
            ) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    addedToItinerary = true
                }
            }

            Button {
                appVM.backFromDetail()
            } label: {
                Text("Back to Trip Plan")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
        }
        .opacity(showContent ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.3), value: showContent)
    }
}
