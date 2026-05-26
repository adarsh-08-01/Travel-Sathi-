import SwiftUI

// MARK: - Packing List View
struct PackingListView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var expandedCategories: Set<PackingCategory> = Set(PackingCategory.allCases)
    @State private var showConfetti = false
    @State private var appeared = false

    private var plan: PackingList? { appVM.packingList }

    var body: some View {
        ZStack {
            GlowingBackground(
                primaryColor: Color(hex: "FDCB6E"),
                secondaryColor: Color(hex: "6C5CE7")
            )

            VStack(spacing: 0) {
                // Header
                headerSection
                    .padding(.top, 56)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                // Progress Bar
                if let plan = plan {
                    progressSection(plan: plan)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                }

                // Profile Switcher Pill
                HStack {
                    Label("Packing for", systemImage: "person.fill")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppColors.textTertiary)
                    ProfilePillButton()
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 14)

                // Items List
                if let plan = plan {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(plan.categoriesWithItems(), id: \.self) { category in
                                PackingCategorySection(
                                    category: category,
                                    items: plan.items(for: category),
                                    isExpanded: expandedCategories.contains(category)
                                ) {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                        if expandedCategories.contains(category) {
                                            expandedCategories.remove(category)
                                        } else {
                                            expandedCategories.insert(category)
                                        }
                                    }
                                } onToggleItem: { id in
                                    appVM.togglePackItem(id: id)
                                    checkCompletion()
                                }
                            }

                            // Bottom CTA
                            bottomCTA
                                .padding(.top, 8)
                                .padding(.bottom, 50)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 4)
                    }
                } else {
                    Spacer()
                    ProgressView()
                        .tint(AppColors.primary)
                    Spacer()
                }
            }

            // Confetti overlay when all packed
            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                appeared = true
            }
        }
    }

    // MARK: Header
    private var headerSection: some View {
        HStack(alignment: .top) {
            Button {
                appVM.backFromPackingList()
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
                Text("Pack Smart 🎒")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
                if let dest = appVM.selectedDestination {
                    Text(dest.name)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                }
            }

            Spacer()

            // Reset button
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    if let dest = appVM.selectedDestination {
                        appVM.packingList = PackingListService.shared.generatePackingList(
                            for: dest, profile: appVM.userProfile
                        )
                        showConfetti = false
                    }
                }
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
                    .frame(width: 40, height: 40)
                    .background(AppColors.backgroundCard.opacity(0.8))
                    .clipShape(Circle())
            }
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : -20)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.05), value: appeared)
    }

    // MARK: Progress Section
    private func progressSection(plan: PackingList) -> some View {
        GlassCard(cornerRadius: 18) {
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(plan.isComplete ? "All Packed! 🎉" : "Packing Progress")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(plan.isComplete ? AppColors.secondary : AppColors.textPrimary)

                        Text("\(plan.packedCount) of \(plan.totalCount) items packed")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(AppColors.textTertiary)
                    }

                    Spacer()

                    // Progress ring
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.1), lineWidth: 5)
                            .frame(width: 52, height: 52)

                        Circle()
                            .trim(from: 0, to: plan.progress)
                            .stroke(
                                LinearGradient(
                                    colors: plan.isComplete
                                        ? [AppColors.secondary, AppColors.secondaryLight]
                                        : [AppColors.primary, AppColors.accent],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 5, lineCap: .round)
                            )
                            .frame(width: 52, height: 52)
                            .rotationEffect(.degrees(-90))
                            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: plan.progress)

                        Text("\(Int(plan.progress * 100))%")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(AppColors.textPrimary)
                    }
                }

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white.opacity(0.08))
                            .frame(height: 8)

                        RoundedRectangle(cornerRadius: 6)
                            .fill(
                                plan.isComplete
                                    ? LinearGradient(colors: [AppColors.secondary, AppColors.secondaryLight],
                                                     startPoint: .leading, endPoint: .trailing)
                                    : LinearGradient(colors: [AppColors.primary, AppColors.accent],
                                                     startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: geo.size.width * plan.progress, height: 8)
                            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: plan.progress)
                    }
                }
                .frame(height: 8)
            }
            .padding(16)
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.12), value: appeared)
    }

    // MARK: Bottom CTA
    private var bottomCTA: some View {
        VStack(spacing: 12) {
            PrimaryButton("Back to Trip Plan", icon: "map.fill", gradient: AppColors.gradientPrimary) {
                appVM.backFromPackingList()
            }
            PrimaryButton("Rate This Trip", icon: "star.fill", gradient: AppColors.gradientAccent) {
                appVM.proceedToFeedback()
            }
        }
    }

    private func checkCompletion() {
        guard let plan = appVM.packingList, plan.isComplete else { return }
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            showConfetti = true
        }
        let haptic = UINotificationFeedbackGenerator()
        haptic.notificationOccurred(.success)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation { showConfetti = false }
        }
    }
}

// MARK: - Packing Category Section
struct PackingCategorySection: View {
    let category: PackingCategory
    let items: [PackingItem]
    let isExpanded: Bool
    let onToggle: () -> Void
    let onToggleItem: (String) -> Void

    private var packedCount: Int { items.filter { $0.isPacked }.count }

    var body: some View {
        GlassCard(cornerRadius: 18) {
            VStack(spacing: 0) {
                // Category Header (tappable)
                Button(action: onToggle) {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: category.colorHex).opacity(0.18))
                                .frame(width: 40, height: 40)
                            Text(category.emoji)
                                .font(.system(size: 18))
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(category.rawValue)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(AppColors.textPrimary)
                            Text("\(packedCount)/\(items.count) packed")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(AppColors.textTertiary)
                        }

                        Spacer()

                        // Mini progress pill
                        if packedCount == items.count && items.count > 0 {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(AppColors.secondary)
                                .font(.system(size: 18))
                        } else {
                            Text("\(items.count - packedCount) left")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Color(hex: category.colorHex))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(hex: category.colorHex).opacity(0.12))
                                .clipShape(Capsule())
                        }

                        Image(systemName: "chevron.down")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(AppColors.textTertiary)
                            .rotationEffect(.degrees(isExpanded ? 0 : -90))
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isExpanded)
                    }
                    .padding(16)
                }
                .buttonStyle(.plain)

                // Items
                if isExpanded {
                    Divider()
                        .background(Color.white.opacity(0.07))
                        .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        ForEach(items) { item in
                            PackingItemRow(item: item) {
                                onToggleItem(item.id)
                            }
                            if item.id != items.last?.id {
                                Divider()
                                    .background(Color.white.opacity(0.04))
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Packing Item Row
struct PackingItemRow: View {
    let item: PackingItem
    let onToggle: () -> Void
    @State private var pressed = false

    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 14) {
                // Checkbox
                ZStack {
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(item.isPacked
                              ? Color(hex: item.category.colorHex)
                              : Color.clear)
                        .frame(width: 26, height: 26)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7, style: .continuous)
                                .strokeBorder(
                                    item.isPacked
                                        ? Color(hex: item.category.colorHex)
                                        : Color.white.opacity(0.2),
                                    lineWidth: 1.5
                                )
                        )

                    if item.isPacked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.spring(response: 0.28, dampingFraction: 0.6), value: item.isPacked)

                // Emoji + Name
                Text(item.emoji)
                    .font(.system(size: 18))

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(item.name)
                            .font(.system(size: 14, weight: item.isEssential ? .semibold : .regular))
                            .foregroundStyle(item.isPacked ? AppColors.textTertiary : AppColors.textPrimary)
                            .strikethrough(item.isPacked, color: AppColors.textTertiary)
                            .animation(.easeInOut(duration: 0.2), value: item.isPacked)

                        if item.isEssential && !item.isPacked {
                            Text("MUST")
                                .font(.system(size: 9, weight: .black))
                                .foregroundStyle(Color(hex: "e17055"))
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(Color(hex: "e17055").opacity(0.15))
                                .clipShape(Capsule())
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .scaleEffect(pressed ? 0.97 : 1.0)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in withAnimation(.easeInOut(duration: 0.1)) { pressed = true } }
                .onEnded { _ in withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) { pressed = false } }
        )
    }
}

// MARK: - Confetti View (celebration when all packed)
struct ConfettiView: View {
    let colors: [Color] = [
        Color(hex: "6C5CE7"), Color(hex: "00B894"), Color(hex: "FDCB6E"),
        Color(hex: "e17055"), Color(hex: "0984e3"), Color(hex: "a29bfe")
    ]

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let time = timeline.date.timeIntervalSinceReferenceDate
                for i in 0..<60 {
                    let seed = Double(i) * 137.508
                    let x = (sin(seed + time * (0.3 + seed.truncatingRemainder(dividingBy: 0.4))) * 0.5 + 0.5) * size.width
                    let y = (time * (80 + seed.truncatingRemainder(dividingBy: 60))).truncatingRemainder(dividingBy: size.height + 20)
                    let rotation = Angle.degrees(seed + time * 120)
                    let color = colors[i % colors.count]

                    context.translateBy(x: x, y: y)
                    context.rotate(by: rotation)
                    let rect = CGRect(x: -5, y: -5, width: 10, height: 6)
                    context.fill(Path(roundedRect: rect, cornerRadius: 2), with: .color(color.opacity(0.85)))
                    context.rotate(by: .degrees(-rotation.degrees))
                    context.translateBy(x: -x, y: -y)
                }
            }
        }
    }
}
