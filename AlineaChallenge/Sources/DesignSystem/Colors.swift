import SwiftUI

// MARK: - Color Palette

extension Color {
    static let primaryText = Color.white
    static let placeholderText = Color.white.opacity(0.4)
    static let background = Color(.appBackground)
    static let bubble = Color(.suggestionBubble).opacity(0.75)
}

// MARK: - Gradients

extension LinearGradient {
    static let brand = LinearGradient(
        colors: [Color(.reviewGradientStart), Color(.reviewGradientEnd)],
        startPoint: .leading,
        endPoint: .trailing
    )
}
