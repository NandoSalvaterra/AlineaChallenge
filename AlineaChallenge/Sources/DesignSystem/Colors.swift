import SwiftUI

// MARK: - Semantic Colors

extension Color {
    static let primaryText     = Color.white
    static let placeholderText = Color.white.opacity(0.4)
    static let background      = Color(.gray950)
    static let bubble          = Color(.purple800).opacity(0.75)
    static let brandStart      = Color(.purple400)
    static let brandEnd        = Color(.purple500)
    static let brandGlowAccent = Color(.yellow200)
}

// MARK: - Gradients

extension LinearGradient {
    static let brand = LinearGradient(
        colors: [.brandStart, .brandEnd],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// MARK: - Review Button Color Sets

extension Color {
    static let reviewBorderColors: [Color] = [
        .brandStart,
        .brandEnd,
        .brandEnd.opacity(0.5),
        .brandStart.opacity(0.5),
        .brandStart
    ]
    
    static let reviewGlowColors: [Color] = [
        .brandStart,
        .brandEnd,
        .brandGlowAccent,
        .white
    ]
}
