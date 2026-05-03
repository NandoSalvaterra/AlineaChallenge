import SwiftUI

struct InvestmentView: View {
    @State private var hasValue = false

    private enum ViewID { case review, bubbles }

    private static let transitionAnimation = Animation.spring(response: 0.4, dampingFraction: 0.7)
    private static let switchTransition = AnyTransition.scale(scale: 0.5).combined(with: .opacity)

    private let horizontalContentPadding: CGFloat = 24
    private let keypadHorizontalPadding: CGFloat = 46
    private let keypadTopSpacing: CGFloat = 46
    private let keypadBottomPadding: CGFloat = 6

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    AmountDisplayView(displayValue: "$0", isEmpty: true)
                        .padding(.horizontal, horizontalContentPadding)

                    Spacer()

                    Group {
                        if hasValue {
                            ReviewButtonView(onTap: {
                                withAnimation(Self.transitionAnimation) { hasValue = false }
                            })
                            .id(ViewID.review)
                            .transition(Self.switchTransition)
                        } else {
                            SuggestionBubblesView(suggestions: [500, 2_000, 10_000], onSelect: { _ in
                                withAnimation(Self.transitionAnimation) { hasValue = true }
                            })
                            .id(ViewID.bubbles)
                            .transition(Self.switchTransition)
                        }
                    }
                    .padding(.horizontal, horizontalContentPadding)

                    KeypadView(isDecimalDisabled: false, onKeyTap: { _ in })
                        .padding(.top, keypadTopSpacing)
                        .padding(.horizontal, keypadHorizontalPadding)
                        .padding(.bottom, keypadBottomPadding)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.background, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image.backButton
                        .onTapGesture { }
                }.sharedBackgroundVisibility(.hidden)
                
                ToolbarItem(placement: .principal) {
                    AutomatedBadgeView()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    InvestmentView()
}
