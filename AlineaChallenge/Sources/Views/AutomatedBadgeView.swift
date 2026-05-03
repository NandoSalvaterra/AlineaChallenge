import SwiftUI

struct AutomatedBadgeView: View {
    private let horizontalPadding: CGFloat = 6
    private let verticalPadding: CGFloat = 4

    var body: some View {
        Text(.automatedBadge)
            .automatedBadgeTextStyle()
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background {
                Image.capsule
                    .resizable()
                
            }
    }
}

#Preview {
    AutomatedBadgeView()
        .padding()
        .background(Color.background)
}
