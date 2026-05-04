import SwiftUI

struct ReviewButtonView: View {
    let onTap: () -> Void

    @State private var rotation: Double = 0
    @State private var glowOpacity: Double = glowOpacityMin

    private static let glowOpacityMin: Double = 0.4
    private static let glowOpacityMax: Double = 0.7
    private static let borderRotationDuration: TimeInterval = 3
    private static let glowPulseDuration: TimeInterval = 1.5
    private static let fullRotation: Double = 360

    private let borderWidth: CGFloat = 1.5
    private let height: CGFloat = 50
    private let glowBleedPadding: CGFloat = 4
    private let glowBlurRadius: CGFloat = 8

    var body: some View {
        button
            .background { glowLayer }
            .onAppear {
                withAnimation(.linear(duration: Self.borderRotationDuration).repeatForever(autoreverses: false)) {
                    rotation = Self.fullRotation
                }
                withAnimation(.easeInOut(duration: Self.glowPulseDuration).repeatForever(autoreverses: true)) {
                    glowOpacity = Self.glowOpacityMax
                }
            }
    }

    private var glowLayer: some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: Color.reviewGlowColors,
                    startPoint: .trailing,
                    endPoint: .leading
                )
            )
            .padding(-glowBleedPadding)
            .blur(radius: glowBlurRadius)
            .opacity(glowOpacity)
    }

    private var button: some View {
        Button(action: onTap) {
            Text(.reviewButton)
                .reviewButtonTextStyle()
                .foregroundStyle(Color.background)
                .frame(maxWidth: .infinity, minHeight: height)
        }
        .accessibilityIdentifier(AccessibilityID.reviewButton)
        .background(.white, in: .capsule)
        .overlay {
            Capsule()
                .stroke(
                    AngularGradient(
                        colors: Color.reviewBorderColors,
                        center: .center,
                        startAngle: .degrees(rotation),
                        endAngle: .degrees(rotation + Self.fullRotation)
                    ),
                    lineWidth: borderWidth
                )
        }
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        ReviewButtonView(onTap: {})
            .padding(.horizontal, 24)
    }
}
