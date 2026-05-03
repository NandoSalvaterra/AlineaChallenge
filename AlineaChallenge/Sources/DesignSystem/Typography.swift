import SwiftUI

// MARK: - Custom Fonts

extension Font {
    static func flexaCondensedMedium(size: CGFloat) -> Font {
        .custom("GTFlexa-CnMd", size: size)
    }

    static func flexaBold(size: CGFloat) -> Font {
        .custom("GTFlexaTrialVF-Bold", size: size)
    }

    static func instrumentSansSemiCondensedMedium(size: CGFloat) -> Font {
        .custom("InstrumentSansSemiCondensed-Medium", size: size)
    }
}

// MARK: - Font Sizes

extension Font {
    enum Size {
        static let amountDisplay: CGFloat = 100
        static let keypadKey: CGFloat = 36
        static let reviewButton: CGFloat = 21
        static let suggestionBubble: CGFloat = 17
        static let automatedBadge: CGFloat = 12
    }
}

// MARK: - Text Styles

extension View {
    func amountDisplayStyle() -> some View {
        self
            .font(.flexaCondensedMedium(size: Font.Size.amountDisplay))
            .tracking(Font.Size.amountDisplay * -0.02)
    }

    func keypadKeyStyle() -> some View {
        self
            .font(.system(size: Font.Size.keypadKey, weight: .medium))
            .tracking(Font.Size.keypadKey * -0.03)
            .foregroundStyle(Color.primaryText)
    }

    func reviewButtonTextStyle() -> some View {
        self
            .font(.flexaCondensedMedium(size: Font.Size.reviewButton))
            .tracking(Font.Size.reviewButton * -0.03)
    }

    func suggestionBubbleTextStyle() -> some View {
        self
            .font(.instrumentSansSemiCondensedMedium(size: Font.Size.suggestionBubble))
            .tracking(Font.Size.suggestionBubble * -0.01)
            .foregroundStyle(Color.primaryText)
    }

    func automatedBadgeTextStyle() -> some View {
        self
            .font(.flexaBold(size: Font.Size.automatedBadge))
            .tracking(Font.Size.automatedBadge * 0.05)
            .foregroundStyle(Color.primaryText)
    }
}
