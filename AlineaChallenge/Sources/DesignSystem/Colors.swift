import SwiftUI

// MARK: - Color Palette

extension Color {
    static let primaryText = Color.white
    static let placeholderText = Color.white.opacity(0.4)
    static let appBackground = Color(.appBackground)
    static let suggestionBubble = Color(.suggestionBubble).opacity(0.75)
}

// MARK: - Gradients

extension LinearGradient {
    static let brand = LinearGradient(
        colors: [Color(.reviewGradientStart), Color(.reviewGradientEnd)],
        startPoint: .leading,
        endPoint: .trailing
    )
}
