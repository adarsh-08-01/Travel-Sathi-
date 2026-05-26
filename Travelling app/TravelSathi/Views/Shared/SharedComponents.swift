import SwiftUI

// MARK: - Shared Components

// MARK: Primary Button
struct PrimaryButton: View {
    let title: String
    let icon: String?
    let gradient: LinearGradient
    let action: () -> Void
    var isDisabled: Bool = false

    init(_ title: String, icon: String? = nil,
         gradient: LinearGradient = AppColors.gradientPrimary,
         isDisabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.gradient = gradient
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 17, weight: .semibold))
                }
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                Group {
                    if isDisabled {
                        LinearGradient(colors: [AppColors.textTertiary, AppColors.textTertiary],
                                       startPoint: .leading, endPoint: .trailing)
                    } else {
                        gradient
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: isDisabled ? .clear : Color(hex: "6C5CE7").opacity(0.4), radius: 12, y: 6)
        }
        .disabled(isDisabled)
        .scaleEffect(isDisabled ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isDisabled)
    }
}

// MARK: Glass Card
struct GlassCard<Content: View>: View {
    var cornerRadius: CGFloat = 20
    let content: () -> Content

    init(cornerRadius: CGFloat = 20, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content
    }

    var body: some View {
        content()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(AppColors.backgroundCard.opacity(0.85))
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [Color.white.opacity(0.15), Color.white.opacity(0.03)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            ), lineWidth: 1
                        )
                }
            )
    }
}

// MARK: Glowing Orb Background
struct GlowingBackground: View {
    @State private var animate = false
    var primaryColor: Color = Color(hex: "6C5CE7")
    var secondaryColor: Color = Color(hex: "00B894")

    var body: some View {
        ZStack {
            AppColors.backgroundDeep.ignoresSafeArea()

            Circle()
                .fill(primaryColor.opacity(0.25))
                .frame(width: 350, height: 350)
                .blur(radius: 80)
                .offset(x: animate ? -60 : 60, y: animate ? -250 : -200)
                .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: animate)

            Circle()
                .fill(secondaryColor.opacity(0.18))
                .frame(width: 280, height: 280)
                .blur(radius: 70)
                .offset(x: animate ? 100 : -80, y: animate ? 280 : 330)
                .animation(.easeInOut(duration: 5).repeatForever(autoreverses: true).delay(1), value: animate)

            Circle()
                .fill(Color(hex: "FDCB6E").opacity(0.12))
                .frame(width: 200, height: 200)
                .blur(radius: 60)
                .offset(x: animate ? 120 : 60, y: animate ? 150 : 200)
                .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true).delay(0.5), value: animate)
        }
        .onAppear { animate = true }
    }
}

// MARK: Star Rating View
struct StarRatingView: View {
    @Binding var rating: Int
    var maxRating: Int = 5
    var starSize: CGFloat = 36

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.system(size: starSize))
                    .foregroundStyle(index <= rating ? AppColors.starFilled : AppColors.starEmpty)
                    .scaleEffect(index <= rating ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: rating)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            rating = index
                        }
                    }
            }
        }
    }
}

// MARK: Badge View
struct BadgeView: View {
    let text: String
    let colorHex: String

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(Color(hex: colorHex))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(hex: colorHex).opacity(0.15))
            .clipShape(Capsule())
    }
}

// MARK: Loading Dots View
struct LoadingDotsView: View {
    @State private var phase = 0

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { i in
                Circle()
                    .fill(AppColors.primaryLight)
                    .frame(width: 10, height: 10)
                    .scaleEffect(phase == i ? 1.4 : 0.8)
                    .opacity(phase == i ? 1.0 : 0.4)
                    .animation(.easeInOut(duration: 0.5).repeatForever().delay(Double(i) * 0.2), value: phase)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                phase = (phase + 1) % 3
            }
            // Cycle through dots
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation {
                    phase = (phase + 1) % 3
                }
            }
        }
    }
}

// MARK: Rating Stars (Display Only)
struct RatingStarsView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: starName(for: i))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.starFilled)
            }
            Text(String(format: "%.1f", rating))
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    private func starName(for index: Int) -> String {
        if Double(index) <= rating { return "star.fill" }
        if Double(index) - rating < 1 { return "star.leadinghalf.filled" }
        return "star"
    }
}
