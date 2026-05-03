import SwiftUI

struct InvestmentView: View {
    @State private var hasValue = false

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

                    if hasValue {
                        ReviewButtonView(onTap: { })
                            .padding(.horizontal, horizontalContentPadding)
                    } else {
                        SuggestionBubblesView(suggestions: [500, 2_000, 10_000], onSelect: { _ in })
                            .padding(.horizontal, horizontalContentPadding)
                    }

                    KeypadView(isDecimalDisabled: false, onKeyTap: { _ in })
                        .padding(.top, keypadTopSpacing)
                        .padding(.horizontal, keypadHorizontalPadding)
                        .padding(.bottom, keypadBottomPadding)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
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
    }
}

#Preview {
    InvestmentView()
}
