import SwiftUI

struct InvestmentView: View {
    @State private var viewModel = InvestmentViewModel()

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

                    AmountDisplayView(displayValue: viewModel.displayValue, isEmpty: viewModel.isEmpty)
                        .transaction { $0.animation = nil }
                        .padding(.horizontal, horizontalContentPadding)

                    Spacer()

                    Group {
                        if viewModel.hasValue {
                            ReviewButtonView(onTap: {
                                withAnimation(Self.transitionAnimation) { }
                            })
                            .id(ViewID.review)
                            .transition(Self.switchTransition)
                        } else {
                            SuggestionBubblesView(suggestions: viewModel.suggestions, onSelect: { value in
                                withAnimation(Self.transitionAnimation) { viewModel.selectSuggestion(value) }
                            })
                            .id(ViewID.bubbles)
                            .transition(Self.switchTransition)
                        }
                    }
                    .padding(.horizontal, horizontalContentPadding)

                    KeypadView(isDecimalDisabled: viewModel.isDecimalDisabled, onKeyTap: { key in
                        withAnimation(Self.transitionAnimation) { viewModel.keyTapped(key) }
                    })
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
