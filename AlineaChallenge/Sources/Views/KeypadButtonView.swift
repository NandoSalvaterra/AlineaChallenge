import SwiftUI

struct KeypadButtonView: View {
    let key: KeypadKey
    let isEnabled: Bool
    let expandsHorizontally: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            content
                .frame(maxWidth: expandsHorizontally ? .infinity : nil)
                .opacity(isEnabled ? 1 : 0.3)
        }
        .disabled(!isEnabled)
    }

    @ViewBuilder
    private var content: some View {
        switch key {
        case .digit(let n):
            Text(verbatim: String(n))
                .keypadKeyStyle()

        case .decimal:
            Text(Locale.current.decimalSeparator ?? ".")
                .keypadKeyStyle()

        case .backspace:
            Image.backspace
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.primaryText)
                .frame(height: Font.Size.keypadKey)
        }
    }
}

#Preview {
    HStack {
        KeypadButtonView(key: .digit(1), isEnabled: true, expandsHorizontally: false, onTap: {})
        KeypadButtonView(key: .decimal, isEnabled: true, expandsHorizontally: true, onTap: {})
        KeypadButtonView(key: .decimal, isEnabled: false, expandsHorizontally: false, onTap: {})
        KeypadButtonView(key: .backspace, isEnabled: true, expandsHorizontally: false, onTap: {})
    }
    .padding()
    .background(.black)
}
