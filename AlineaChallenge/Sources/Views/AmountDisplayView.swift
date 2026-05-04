import SwiftUI

struct AmountDisplayView: View {
    let displayValue: String
    let isEmpty: Bool
    
    @State private var cursorVisible = true
    
    private let cursorWidth: CGFloat = 3
    private let cursorSpacing: CGFloat = 4
    
    var body: some View {
        HStack(spacing: cursorSpacing) {
            Text(displayValue)
                .embossed(isEmpty: isEmpty)
                .amountDisplayStyle()
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .accessibilityIdentifier(AccessibilityID.amountDisplay)
                .transaction { $0.animation = nil }
            
            Rectangle()
                .fill(Color.primaryText)
                .frame(width: cursorWidth)
                .opacity(cursorVisible ? 1 : 0)
        }
        .fixedSize(horizontal: false, vertical: true)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                cursorVisible = false
            }
        }
    }
}

#Preview {
    VStack(spacing: 32) {
        AmountDisplayView(displayValue: "$0", isEmpty: true)
        AmountDisplayView(displayValue: "$2,000", isEmpty: false)
        AmountDisplayView(displayValue: "$1,234,567.89", isEmpty: false)
    }
    .padding()
    .background(Color.background)
}
