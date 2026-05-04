import SwiftUI

struct SuggestionBubblesView: View {
    let suggestions: [Decimal]
    let onSelect: (Decimal) -> Void

    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    private let bubbleSpacing: CGFloat = 12
    private let bubbleHeight: CGFloat = 44

    var body: some View {
        HStack(spacing: bubbleSpacing) {
            ForEach(suggestions, id: \.self) { value in
                bubble(for: value)
            }
        }
    }

    private func bubble(for value: Decimal) -> some View {
        Button {
            onSelect(value)
        } label: {
            Text(verbatim: Self.currencyFormatter.string(from: value as NSDecimalNumber) ?? "\(value)")
                .suggestionBubbleTextStyle()
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(maxWidth: .infinity, minHeight: bubbleHeight)
        }
        .glassEffect(.regular.tint(Color.bubble), in: .capsule)
        .accessibilityIdentifier(AccessibilityID.suggestion(value))
    }
}

#Preview {
    SuggestionBubblesView(suggestions: [500, 2_000, 10_000], onSelect: { _ in })
        .padding()
        .background(Color.background)
}
